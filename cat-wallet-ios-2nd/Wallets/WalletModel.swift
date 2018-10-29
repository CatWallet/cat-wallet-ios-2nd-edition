//
//  WalletModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import web3swift


struct WalletModel {
    let address: String
    let data: Data?
    let name: String
    let isHD: Bool
    
    static func storedWallets(crModel: WalletModel) -> WalletModel{
        let model = WalletModel(address: crModel.address , data: crModel.data, name: crModel.name, isHD: crModel.isHD)
        return model
    }
}

extension WalletModel: Equatable {
    static func == (lhs: WalletModel, rhs: WalletModel) -> Bool {
        return lhs.address == rhs.address
    }
}

struct HDKey {
    let name: String?
    let address: String
}
