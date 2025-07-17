//
//  StockListView.swift
//  StockApp
//
//  Created by Chetan Rajauria on 27/06/25.
//

import SwiftUI

struct StockListView: View {
    
    @StateObject var viewmodel = StockListViewModel()
    var body: some View {
        
        NavigationStack {
            List(viewmodel.stocks) { stock in
                StockRowView(stock: stock) {
                    viewmodel.toggleWishlist(for: stock)
                }
            }
            .navigationTitle("Stocks")
            .toolbar {
                NavigationLink("Wishlist") {
                    WishListView(viewmodel: viewmodel)
                }
            }
        }
    }
}

#Preview {
    StockListView()
}
