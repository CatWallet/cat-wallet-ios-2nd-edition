//
//  RealmModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import RealmSwift
import Web3swift



class KeyStoreRealm: Object {
    @objc dynamic var walletName: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var btcaddress: String = ""
    @objc dynamic var data: Data?
    @objc dynamic var name: String = ""
    @objc dynamic var mnemonics : String = ""
}

class CurrentKeyStoreRealm: Object {
    @objc dynamic var walletName: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var btcaddress: String = ""
    @objc dynamic var data: Data?
    @objc dynamic var name: String = ""
    @objc dynamic var mnemonics : String = ""
}


