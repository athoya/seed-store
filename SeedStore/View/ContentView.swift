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
                    Task {
                        try await viewModel.purchase(product: item)
                    }
                }
            }
        }
        .padding()
        .task {
            await viewModel.getProducts()
        }
    }
}

#Preview {
    ContentView()
}
