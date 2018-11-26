//
//  String.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailTestCase = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailTestCase)
        return emailTest.evaluate(with: self)
    }
}
