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
    // create variable to listen the transaction
    var transactionListener: Task<Void, Error>? = nil
    
    deinit {
        transactionListener?.cancel()
    }
    
    // If your app has unfinished transactions, the updates listener receives them once, immediately after the app launches. Without the Task to listen for these transactions, your app may miss them.
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
    
    // Configure the helper to asign the transaction listener
    func configure() async throws {
        transactionListener = createTransactionTask()
    }
    
    // A function to check whether the transaction is valid
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
    
    // Wrapper function to call purchase from app store, return purchased product as result
    func purchase(product: Product) async throws -> Result<Product, Error> {
        // 4. purchase the product and determine the transaction status
        return .failure(StoreError.unknownError)
    }
    
}
