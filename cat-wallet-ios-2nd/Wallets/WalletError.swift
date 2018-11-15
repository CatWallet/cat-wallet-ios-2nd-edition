//
//  WalletError.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation

enum Errors: LocalizedError {
    case couldNotCreateKeystore
    case couldNotCreateWalletWithAddress
    case couldNotGetKeyData
    case couldNotCreateAddress
    case couldNotGenerateMnemonics
    
    var errorDescription: String? {
        switch self {
        case .couldNotCreateKeystore:
            return "Could Not Create Keystore"
        case .couldNotCreateWalletWithAddress:
            return "Could Not Create Wallet With Address"
        case .couldNotGetKeyData:
            return "Could Not Get Key Data"
        case .couldNotCreateAddress:
            return "Could Not Create Address"
        case .couldNotGenerateMnemonics:
            return "Could Not Generate Mnemonics"
        }
    }
}
