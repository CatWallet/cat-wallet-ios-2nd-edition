//
//  MainTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/30/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift
import HexColors
import EthereumAddress
import SWSegmentedControl


class MainTableViewController: UITableViewController, ReloadTableView {
    
    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var buttonConstraint: NSLayoutConstraint!
    var sendButton: UIButton!
    var sendBtcButton: UIButton!
    var segment: SWSegmentedControl!
    var textView: UITextView!
    @IBOutlet weak var barItem: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        keyStore = ws.fetchCurrenKeyStore()
        self.tableView.tableFooterView = UIView()
        setSegmentedControl()
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        tableView.reloadData()
}
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        textView = UITextView(frame: CGRect(x: 0, y: height/3, width: width, height: 30))
        textView.textAlignment = .center
        textView.text = "Create a wallet!"
        textView.font = UIFont(name: "Avenir-Light", size: 18)
        textView.textColor = UIColor("#0E59B4")
        if walletDetect() {
            textView.text = "Welcome back"
            self.view.addSubview(textView)
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.white
            return 1
        } else {
            let button = UIButton()
            self.navigationItem.rightBarButtonItem = nil
            button.addTarget(self, action: #selector(add), for: .touchUpInside)
            button.setBackgroundImage(UIImage(named: "add"), for: .normal)
            button.frame = CGRect(x: width/2 - 20, y: height/3.6, width: 40, height: 40)
            self.view.addSubview(button)
            self.view.addSubview(textView)
            return 0
        }
    }
    
    @objc func add() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            print("00000")
        case 1:
            print("11111")
        default:
            break
        }
    }
    
    @objc func segmentAction() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            textView.text = "Create a wallet!"
        case 1:
            textView.text = "Import a wallet"
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sendCoinCell", for: indexPath) as! SendTableViewCell
        if indexPath.row == 0 {
        cell.coinNum.text = "x" + ws.getBalance(keyStore)
        } else {
            cell.coinImage.image = UIImage(named: "bitcoin")
            cell.coinName.text = "BTC"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupVC = TransferNavigationViewController()
        if indexPath.row == 0 {
            cryptoName = "ETH"
        } else {
            cryptoName = "BTC"
        }
        present(popupVC, animated: true, completion: nil)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setSegmentedControl() {
        segment = SWSegmentedControl(items: ["New", "Import"])
        segment.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        segment.sizeToFit()
        segment.tintColor = UIColor.white
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
    }
    
    func reloadTableView(_ message: String) {
        print(message)
        self.tableView.reloadData()
    }
    
    func walletDetect() -> Bool {
        let ethAdd = keyStore.address
        if ethAdd != "" {
            return true
        } else {
            return false
        }
    }
}
