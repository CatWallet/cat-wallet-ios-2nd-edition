//
//  Tokens.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import Foundation

struct TokensStructure: Decodable {
    let name: String
    let contract_address: String
    let decimals: Int
}
