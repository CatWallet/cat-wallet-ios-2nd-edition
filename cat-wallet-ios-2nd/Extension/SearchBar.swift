//
//  SearchBar.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import Foundation
import UIKit

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
