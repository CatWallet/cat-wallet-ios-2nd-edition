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
import MBProgressHUD
import EthereumAddress
import SWSegmentedControl


class MainTableViewController: UITableViewController, ReloadTableView {
    
    @IBOutlet weak var itemButton: UIBarButtonItem!
    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var buttonConstraint: NSLayoutConstraint!
    var segment: SWSegmentedControl!
    var textView: UITextView!
    let button = UIButton()
    var loadingNotification = MBProgressHUD()
    @IBOutlet weak var barItem: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyStore = ws.fetchCurrenKeyStore()
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        tableView.register(UINib(nibName: "TotalAssetTableViewCell", bundle: nil), forCellReuseIdentifier: "total")
        self.tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        self.navigationItem.rightBarButtonItem = itemButton
        tableView.reloadData()
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        if walletDetect() {
            UINavigationBar.appearance().tintColor = UIColor.white
            self.title = "Main"
            segment.isHidden = true
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.white
            textView.text = "Add coins"
            //self.navigationItem.rightBarButtonItem = itemButton
            return 1
        } else {
            //self.navigationItem.rightBarButtonItem = nil
            setSegmentedControl()
            textView = UITextView(frame: CGRect(x: 0, y: height/2, width: width, height: 30))
            textView.textAlignment = .center
            textView.text = "Create a wallet"
            textView.font = UIFont(name: "Avenir-Light", size: 18)
            textView.textColor = UIColor("#0E59B4")
            button.addTarget(self, action: #selector(add), for: .touchUpInside)
            button.setBackgroundImage(UIImage(named: "add"), for: .normal)
            button.frame = CGRect(x: width/2 - 20, y: height/2.3, width: 40, height: 40)
            self.view.addSubview(button)
            self.view.addSubview(textView)
            return 0
        }
    }
    
    @objc func add() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            createWallet()
        case 1:
            let viewController = ImportViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    @objc func segmentAction() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            textView.text = "Create a wallet"
            button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        case 1:
            textView.text = "Import a wallet"
            button.setBackgroundImage(UIImage(named: "wallet_import"), for: .normal)
        default:
            break
        }
    }
    
    private func createWallet() {
            self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingNotification.mode = MBProgressHUDMode.indeterminate
        let ws = WalletService()
        ws.createHDWallet(withName: "String", password: "Password") { (keyWallet, error, mnemonics, btcAddress) in
            if error != nil {
                print(error as! String)
            } else {
                let vc = NewWalletResultViewController()
                vc.getAddress = keyWallet?.address ?? ""
                vc.getMnemonics = mnemonics ?? ""
                vc.getBtcAddress = btcAddress ?? ""
                self.loadingNotification.hide(animated: false)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "total", for: indexPath) as! TotalAssetTableViewCell
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendCoinCell", for: indexPath) as! SendTableViewCell
            if indexPath.row == 1 {
            cell.coinNum.text = "x" + ws.getBalance(keyStore)
            } else if indexPath.row == 2 {
                cell.coinImage.image = UIImage(named: "Group8")
                cell.coinName.text = "Bitcoin"
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 191
        } else {
            return 90
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupVC = TransferNavigationViewController()
        
        if indexPath.row == 1 {
            cryptoName = "ETH"
        } else if indexPath.row == 2{
            cryptoName = "BTC"
        } else if indexPath.row == 0{
            return
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
        print(ethAdd)
        if ethAdd != "" {
            return true
        } else {
            return false
        }
    }
}
