//
//  BitcoinService.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/22/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import BitcoinKit

var cryptoName = ""

struct BitcoinService {
    func createBTCWallet(_ mnemonic: String) -> HDWallet{
        let mnemonicList = mnemonic.components(separatedBy: " ")
            let seed = Mnemonic.seed(mnemonic: mnemonicList)
            let wallet = HDWallet(seed: seed, network: .mainnet)
            return wallet
    }
    
    func getRecieveAddress(_ wallet: HDWallet) -> String {
        var btcAddress = ""
        do {
            let address = try wallet.receiveAddress()
            btcAddress = address.cashaddr
        } catch let error {
            print(error.localizedDescription)
        }
        return btcAddress
    }
}
