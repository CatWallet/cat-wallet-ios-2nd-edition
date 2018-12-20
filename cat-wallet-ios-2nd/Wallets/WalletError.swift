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
    case wrongPassword
    case invalidContractAddress
    case invalidAmountFormat
    case noAvailableKeys
    case invalidKey
    case invalidContract
    case invalidDestinationAddress
    case cantCreateWallet
    
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
        case .wrongPassword:
            return "Wrong Password"
        case .invalidContractAddress:
            return "Invalid Contract Address"
        case .invalidAmountFormat:
            return "Invalid Amount Format"
        case .noAvailableKeys:
            return "No Available Keys"
        case .invalidKey:
            return "Invalid Key"
        case .invalidContract:
            return "Invalid Contract"
        case .invalidDestinationAddress:
            return "Invalid Destination Address"
        case .cantCreateWallet:
            return "Cant Create Wallet"
        }
    }
}
