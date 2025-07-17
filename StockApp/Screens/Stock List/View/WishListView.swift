//
//  WishListView.swift
//  StockApp
//
//  Created by Chetan Rajauria on 27/06/25.
//

import SwiftUI

struct WishListView: View {
    @ObservedObject var viewmodel: StockListViewModel
    var body: some View {
        List(viewmodel.wishlistStocks) { stock in
            VStack {
                Text(stock.name)
                Text("\(stock.price, specifier: "%.2f")")
            }
        }
    }
}
