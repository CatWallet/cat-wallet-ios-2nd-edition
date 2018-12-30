//
//  ContactModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var BTCAddress: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
