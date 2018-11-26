//
//  SendNavigationTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/9/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift
import EthereumAddress

class SendNavigationTableViewController: UITableViewController{
    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        keyStore = fetchCurrenKeyStore()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        if walletDetect() {
            tableView.backgroundColor = UIColor.white
            return 1
        } else {
//            let backgroundImage = UIImage(named: "address")
//            let imageView = UIImageView(image: backgroundImage)
//            tableView.backgroundView = imageView
            tableView.backgroundColor = UIColor.black
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sendCoinCell", for: indexPath) as! SendTableViewCell
        cell.coinNum.text = getBalance()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupVC = SendPopUpViewController()
        popupVC.height = height
        popupVC.topCornerRadius = 35
        popupVC.presentDuration = 0.4
        popupVC.dismissDuration = 0.3
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getBalance() -> String{
        if let ethAdd = EthereumAddress(keyStore.address){
            var balance = ""
            do {
                let web3 = Web3.InfuraMainnetWeb3()
                let balancebigint = try web3.eth.getBalance(address: ethAdd)
                balance = String(describing: Web3.Utils.formatToEthereumUnits(balancebigint)!)
            } catch let error {
                print(error)
            }
            return balance
            } else {
                return ""
        }
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

extension SendNavigationTableViewController: BottomPopupDelegate {

    func bottomPopupViewLoaded() {
    }

    func bottomPopupWillAppear() {
    }

    func bottomPopupDidAppear() {
    }

    func bottomPopupWillDismiss() {
    }

    func bottomPopupDidDismiss() {
    }

    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        //print("\(oldValue) to: \(newValue)")
    }
}
