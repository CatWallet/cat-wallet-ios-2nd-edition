//
//  HistoryViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let a = ["01/11/2018", "11/11/2018"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "historyCell")
    }
    
    @objc func historyDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell
        cell?.textLabel?.text = a[indexPath.row]
        return cell!
    }

}
