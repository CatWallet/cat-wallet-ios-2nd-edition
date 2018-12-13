//
//  ChatData.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/12/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation

struct ChatData {
    var name: String
    var message: String
    
    init(getName: String, getMessage: String) {
        name = getName
        message = getMessage
    }
}
