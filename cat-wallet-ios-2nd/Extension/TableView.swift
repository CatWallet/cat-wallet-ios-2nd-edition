//
//  TableView.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/13/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
