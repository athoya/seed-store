//
//  ProductItemView.swift
//  SeedStore
//
//  Created by Athoya on 05/09/24.
//

import SwiftUI
import StoreKit

struct ProductItemView: View {
    typealias PurchaseHandler = (Product) -> Void
    
    var product: Product
    var purchaseHandler: PurchaseHandler?
    
    var body: some View {
        HStack {
            Text(product.displayName)
            Spacer()
            Button {
                purchaseHandler?(product)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text("\(product.displayPrice)").foregroundStyle(.white)
                }.frame(width: 64, height: 42)
            }
        }
    }
}

//#Preview {
//    ProductItemView()
//}
