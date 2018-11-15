//
//  WalletsViewModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import Web3swift

func generateMnemonics(bitsOfEntropy: Int) -> String? {
    guard let mnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy),
        let unwrapped = mnemonics else {
            return nil
    }
    return unwrapped
}

func createHDWallet(withName name: String?,
                    password: String,
                    completion: @escaping (KeyWalletModel?, Error?, String?) -> Void)
{
    
    guard let mnemonics = generateMnemonics(bitsOfEntropy: 128) else {
        completion(nil, Errors.couldNotGenerateMnemonics, nil)
        return
    }
    
    guard let keystore = try? BIP32Keystore(
        mnemonics: mnemonics,
        password: password,
        mnemonicsPassword: "",
        language: .english
        ),
        let wallet = keystore else {
            completion(nil, Errors.couldNotCreateKeystore, nil)
            return
    }
    guard let address = wallet.addresses?.first?.address else {
        completion(nil, Errors.couldNotCreateAddress, nil)
        return
    }
    guard let keyData = try? JSONEncoder().encode(wallet.keystoreParams) else {
        completion(nil, Errors.couldNotGetKeyData, nil)
        return
    }
    let walletModel = KeyWalletModel(address: address,
                                     data: keyData,
                                     name: name ?? "",
                                     isHD: true)
    
    completion(walletModel, nil, mnemonics)
}

