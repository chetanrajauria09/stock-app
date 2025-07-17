//
//  APIEndpoint.swift
//  StockApp
//
//  Created by Chetan Rajauria on 17/07/25.
//

import Foundation

struct APIEndpoint {
    static func stockQuotesEndpoint(symbols: [String]) -> URL? {
        let baseURL = "https://api.tickertape.in/stocks/quotes"
        let query = symbols.joined(separator: ",")
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let fullURL = "\(baseURL)?sids=\(encodedQuery)"
        return URL(string: fullURL)
    }

    static var defaultStockQuotes: URL? {
        stockQuotesEndpoint(symbols: ["RELI", "TCS", "ITC", "HDBK"])
    }
}
