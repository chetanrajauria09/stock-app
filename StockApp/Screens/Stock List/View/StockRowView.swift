//
//  StockRowView.swift
//  StockApp
//
//  Created by Chetan Rajauria on 27/06/25.
//

import SwiftUI

struct StockRowView: View {
    let stock: Stock
    let toogleAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.name)
                Text("\(stock.price, specifier: "%.2f")")
            }
            
            Spacer()
            Image(systemName: stock.price > (stock.previousPrice ?? 0) ? "arrow.up": "arrow.down")
                .foregroundColor(stock.price > (stock.previousPrice ?? 0) ? .green : .red)
            Button(action: toogleAction){
                Image(systemName: stock.isWishlisted ? "heart.fill" : "heart")
            }
        }
    }
}
