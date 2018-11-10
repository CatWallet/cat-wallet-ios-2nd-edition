//
//  WalletsViewModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
//import web3swift

//func createWalletWithPrivateKey(withName: String?,
//                                password: String,
//                                completion: @escaping (WalletModel?, Error?) -> Void)
//{
//    guard let newWallet = try? EthereumKeystoreV3(password: password) else {
//        completion(nil, Errors.couldNotCreateKeystore)
//        return
//    }
//    guard let wallet = newWallet, wallet.addresses?.count == 1 else {
//        completion(nil, Errors.couldNotCreateWalletWithAddress)
//        return
//    }
//    guard let keyData = try? JSONEncoder().encode(wallet.keystoreParams) else {
//        completion(nil, Errors.couldNotGetKeyData)
//        return
//    }
//    guard let address = wallet.addresses?.first?.address else {
//        completion(nil, Errors.couldNotCreateAddress)
//        return
//    }
//    let walletModel = WalletModel(address: address,
//                                     data: keyData,
//                                     name: withName ?? "",
//                                     isHD: false)
//    completion(walletModel, nil)
//}
