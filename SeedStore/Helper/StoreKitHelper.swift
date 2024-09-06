//
//  StoreKitHelper.swift
//  SeedStore
//
//  Created by Athoya on 05/09/24.
//

import Foundation
import StoreKit

public enum StoreError: Error {
    case failedVerification
    case userCancelled
    case unknownError
}

class StoreKitHelper {    
    var transactionListener: Task<Void, Error>? = nil
    
    deinit {
        transactionListener?.cancel()
    }
    
    private func createTransactionTask() -> Task<Void, Error> {
        return Task.detached {
            for await update in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(update)
//                    try await self.updateUserPurchases()
                    await transaction.finish()
                } catch {
                    print("Transaction didn't pass verification - ignoring purchase.")
                }
            }
        }
    }
    
    func configure() async throws {
        do {
            transactionListener = createTransactionTask()
//            try await retrieveAllProducts()
//            try await updateUserPurchases()
        } catch {
            throw error
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
    
    func purchase(product: Product) async throws -> Result<Product, Error> {
        let result = try await product.purchase()
        
        switch(result) {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            print("Success")
            await transaction.finish()
            return .success(product)
        case .userCancelled:
            print("Cancelled by user")
            return .failure(StoreError.userCancelled)
        default:
            print("Unknown error")
            return .failure(StoreError.unknownError)
        }
    }
    
}
