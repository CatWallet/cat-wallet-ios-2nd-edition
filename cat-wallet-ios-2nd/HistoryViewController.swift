//
//  HistoryViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class HistoryViewController: BottomPopupViewController, UITableViewDataSource, UITableViewDelegate {
    let a = ["01/11/2018", "11/11/2018"]
    
    @IBOutlet weak var tableView: UITableView!
    var height = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "historyCell")
    }
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "History")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(historyDismiss))
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
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
    
    override func getPopupHeight() -> CGFloat {
        let stHeight = UIApplication.shared.statusBarFrame.size.height
        let scHeight = UIScreen.main.bounds.size.height
        height = Int(scHeight) - Int(stHeight)
        return CGFloat(height)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return CGFloat(35)
    }
    
    override func getPopupPresentDuration() -> Double {
        return 0.3
    }
    
    override func getPopupDismissDuration() -> Double {
        return 0.4
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }

}
