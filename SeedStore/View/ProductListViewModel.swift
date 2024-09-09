//
//  ProductListViewModel.swift
//  SeedStore
//
//  Created by Athoya on 05/09/24.
//

import Foundation
import StoreKit

class ProductListViewModel: ObservableObject {
    let storeKitHelper = StoreKitHelper()
    @Published var products: [Product] = []
    @Published var seed: Int = 0
    // 1. create arrays of ids to collect of products
    
    // 6. Check the user purchased products
    init() {
        
    }
    
    // 1. function to fecth all product from the app store
    func getProducts() async throws {
        
    }
    
    // 5. function to purchase product and add the benefit after brought the product
    func purchase(product: Product) async throws {
        
    }
    
}
