//
//  MainTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/30/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift
import EthereumAddress


class MainTableViewController: UITableViewController {

    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        keyStore = fetchCurrenKeyStore()
        self.tableView.tableFooterView = UIView()
        title = "Main"
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
        let popupVC = TransferNavigationViewController()
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
