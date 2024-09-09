//
//  ContentView.swift
//  SeedStore
//
//  Created by Athoya on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ProductListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("🌱 Seed: \(viewModel.seed)")
            }
            Text("Welcome to Seed Store")
                    .font(.title)
            ForEach(viewModel.products) { product in
                ProductItemView(product: product) { item in
                    // 3. When tapped, buy the product by calling function from viewModel
                }
            }
        }
        .padding()
        .task {
            // 2. on appear, fetch the product from viewModel
        }
    }
}

#Preview {
    ContentView()
}
