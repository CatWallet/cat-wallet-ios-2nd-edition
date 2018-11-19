//
//  RealmModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import RealmSwift



class KeyStoreRealm: Object {
    @objc dynamic var address: String = ""
    @objc dynamic var data: Data?
    @objc dynamic var name: String = ""
}

class CurrentKeyStoreRealm: Object {
    @objc dynamic var address: String = ""
    @objc dynamic var data: Data?
    @objc dynamic var name: String = ""
}
