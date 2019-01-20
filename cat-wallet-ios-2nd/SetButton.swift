//
//  SetButton.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import UIKit

struct SetButton {
    func setButton(_ button: UIButton, _ num: Int) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = button.frame.width / CGFloat(num)
        //button.layer.borderWidth = 3.5
    }
}
