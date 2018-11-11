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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "historyCell")
        // Do any additional setup after loading the view.
    }
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar);
        
        let navItem = UINavigationItem(title: "History");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(historyDismiss));
        navItem.rightBarButtonItem = doneItem;
        
        navBar.setItems([navItem], animated: false);
    }
    
    @objc func historyDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell
        cell?.nameLabel.text = a[indexPath.row]
        return cell!
    }
    
    override func getPopupHeight() -> CGFloat {
        return CGFloat(820)
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
