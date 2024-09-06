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
    
    init() {
        Task {
            try await storeKitHelper.configure()
        }
    }
    
    func getProducts() async {        
        if let products = try? await Product.products(for: ["consumables.athoya.starter.60", "consumables.athoya.starter.120", "consumables.athoya.starter.240"]) {
            await MainActor.run {
                self.products = products
            }
        } else {
            print("Error fetching products")
        }
    }
    
    func purchase(product: Product) async throws {
        let result = try await storeKitHelper.purchase(product: product)
        let item = try result.get()
        
        await MainActor.run {
            switch item.id {
            case "consumables.athoya.starter.60":
                seed += 60
                break
            case "consumables.athoya.starter.120":
                seed += 120
                break
            case "consumables.athoya.starter.240":
                seed += 240
                break
            default:
                print("Transaction Error")
            }
        }
    }
    
}
