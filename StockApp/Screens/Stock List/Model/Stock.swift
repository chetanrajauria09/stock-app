//
//  Stock.swift
//  StockApp
//
//  Created by Chetan Rajauria on 27/06/25.
//

import Foundation

struct Stock: Identifiable ,Codable {
    var id: String {
        sid
    }
    var name: String
    var price: Double
    let sid: String
    var previousPrice: Double?
    var isWishlisted: Bool = false
    
}

struct StockAPIWrapper: Codable {
    let success: Bool
    let data: [StockAPIResponse]
}

struct StockAPIResponse: Codable {
    let sid: String
    let price: Double
    let close: Double
    let change: Double
    let high: Double
    let low: Double
    let volume: Int
    let date: String
}
