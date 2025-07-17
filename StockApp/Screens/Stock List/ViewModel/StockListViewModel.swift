//
//  StockListViewModel.swift
//  StockApp
//
//  Created by Chetan Rajauria on 27/06/25.
//

import Foundation

@MainActor
class StockListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var wishlistIds: Set<String> = []

    private let endpointURL: URL?
    private let userDefaultKey = "wishlist"
    private let userDefaults: UserDefaults
    private let session: URLSession

    init(
        userDefaults: UserDefaults = .standard,
        session: URLSession = .shared,
        endpointURL: URL? = APIEndpoint.defaultStockQuotes
    ) {
        self.userDefaults = userDefaults
        self.session = session
        self.endpointURL = endpointURL

        loadWishlist()
        Task {
            await startPolling()
        }
    }

    func startPolling() async {
        while true {
            await loadStocks()
            try? await Task.sleep(for: .seconds(5))
        }
    }

    func loadStocks() async {
        guard let url = endpointURL else { return }

        do {
            let (data, _) = try await session.data(from: url)
            let decoded = try JSONDecoder().decode(StockAPIWrapper.self, from: data)

            self.stocks = decoded.data.map { item in
                let existing = self.stocks.first(where: { $0.sid == item.sid })
                return Stock(
                    name: item.sid,
                    price: item.price,
                    sid: item.sid,
                    previousPrice: existing?.price,
                    isWishlisted: wishlistIds.contains(item.sid)
                )
            }
        } catch {
            print("❌ Failed to fetch stocks: \(error.localizedDescription)")
        }
    }

    func toggleWishlist(for stock: Stock) {
        if wishlistIds.contains(stock.sid) {
            wishlistIds.remove(stock.sid)
        } else {
            wishlistIds.insert(stock.sid)
        }
        saveWishlist()
        syncWishlistedFlags()
    }

    private func syncWishlistedFlags() {
        stocks = stocks.map { stock in
            var updated = stock
            updated.isWishlisted = wishlistIds.contains(stock.sid)
            return updated
        }
    }

    private func saveWishlist() {
        userDefaults.set(Array(wishlistIds), forKey: userDefaultKey)
    }

    private func loadWishlist() {
        if let saved = userDefaults.array(forKey: userDefaultKey) as? [String] {
            wishlistIds = Set(saved)
        }
    }

    var wishlistStocks: [Stock] {
        stocks.filter { wishlistIds.contains($0.sid) }
    }
}
