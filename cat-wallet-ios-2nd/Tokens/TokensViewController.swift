//
//  TokensViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import HexColors

class TokensViewController: UIViewController {

    @IBOutlet weak var searchBarButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
    }
    
    func setSearchBar() {
        title = "Tokens"
        let color = UIColor("#0E59B4")
        navigationController?.navigationBar.tintColor = .white
        navigationController!.navigationBar.isTranslucent = false
        searchBarButton.backgroundColor = color
        searchBarButton.tintColor = .white
        searchBar.backgroundColor = color
        searchBar.tintColor = .white
        searchBar.setTextColor(color: UIColor.white)
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
