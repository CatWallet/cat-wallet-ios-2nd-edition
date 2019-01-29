//
//  TokensViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import HexColors

class TokensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var searchBarButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tokensTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        tokensTableView.register(UINib(nibName: "TokensTableViewCell", bundle: nil), forCellReuseIdentifier: "tokensCell")
        tokensTableView.delegate = self
        tokensTableView.dataSource = self
        setSearchBar()
        tokensTableView.tableFooterView = nil
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
    
    func getInfo() {
        TokensServiceHandler.sharedInstance.getTokens { (res) in
            if let tokenServiceResult = res as? [CoinData] {
                //self.coinData = webServiceResult
                DispatchQueue.main.async {
                    self.tokensTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tokensCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
