//
//  StockListViewModelTests.swift
//  StockAppTests
//
//  Created by Chetan Rajauria on 17/07/25.
//

import Testing
@testable import StockApp
import Foundation

@MainActor
struct StockListViewModelTests {
    
    @Test
    func testToggleWishlistAddsAndRemoves() async throws {
        let testDefaults = UserDefaults(suiteName: "TestDefaults")!
        testDefaults.removePersistentDomain(forName: "TestDefaults")
        
        let vm = StockListViewModel(userDefaults: testDefaults)
        
        let stock = Stock(name: "TCS", price: 100, sid: "TCS", previousPrice: nil, isWishlisted: false)
        
        vm.toggleWishlist(for: stock)
        #expect(vm.wishlistIds.contains("TCS"))
        
        vm.toggleWishlist(for: stock)
        #expect(!vm.wishlistIds.contains("TCS"))
    }
    
    @Test
    func testSaveWishlistStoresToUserDefaults() async throws {
        let testDefaults = UserDefaults(suiteName: "TestDefaults")!
        testDefaults.removePersistentDomain(forName: "TestDefaults")
        
        let vm = StockListViewModel(userDefaults: testDefaults)
        
        let stock = Stock(name: "ITC", price: 100, sid: "ITC", previousPrice: nil, isWishlisted: false)
        
        vm.toggleWishlist(for: stock)
        
        let saved = testDefaults.array(forKey: "wishlist") as? [String]
        #expect(saved?.contains("ITC") == true)
    }
    
    @Test
    func testWishlistFilterReturnsCorrectStocks() async throws {
        let vm = StockListViewModel()
        vm.stocks = [
            Stock(name: "TCS", price: 100, sid: "TCS", previousPrice: nil, isWishlisted: true),
            Stock(name: "ITC", price: 200, sid: "ITC", previousPrice: nil, isWishlisted: false)
        ]
        vm.wishlistIds = ["TCS"]
        
        let wishlist = vm.wishlistStocks
        #expect(wishlist.count == 1)
        #expect(wishlist.first?.sid == "TCS")
    }
    
    @Test
    func testLoadWishlistReadsFromUserDefaults() async throws {
        UserDefaults.standard.set(["HDBK", "TCS"], forKey: "wishlist")
        let vm = StockListViewModel()
        #expect(vm.wishlistIds.contains("HDBK"))
        #expect(vm.wishlistIds.contains("TCS"))
    }
}
