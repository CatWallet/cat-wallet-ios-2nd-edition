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


class MainTableViewController: UITableViewController, ReloadTableView {
    
    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var buttonConstraint: NSLayoutConstraint!
    var sendButton: UIButton!
    var sendBtcButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        keyStore = ws.fetchCurrenKeyStore()
        self.tableView.tableFooterView = UIView()
        title = "Main"
        tableView.reloadData()
}
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let backgroundImage = UIImage(named: "wallet_large")
        let imageView = UIImageView(image: backgroundImage)
        let width = UIScreen.main.bounds.size.width
        let textView = UITextView(frame: CGRect(x: 0, y: 240, width: width, height: 20))
        textView.textAlignment = .center
        textView.text = "Clikc the button on the top right corner of the page"
        if walletDetect() {
            //setSendButton()
            //setBtcSendButton()
            textView.text = "Welcome back"
            self.view.addSubview(textView)
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.white
            return 1
        } else {
            self.view.addSubview(textView)
            imageView.contentMode = .center
            tableView.backgroundView = imageView
            return 0
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
    
    func reloadTableView(_ message: String) {
        print(message)
        self.tableView.reloadData()
    }
    
    func setSendButton() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var y: CGFloat?
        if statusHeight == 20{
            y = UIScreen.main.bounds.height - 4.5*(tabBarController?.tabBar.frame.size.height)!
        } else {
            y = UIScreen.main.bounds.height - 3.5*(tabBarController?.tabBar.frame.size.height)!
        }
        let x = UIScreen.main.bounds.width/4
        sendButton = UIButton(frame: CGRect(x: x*3, y: y!, width: 50, height: 50))
        sendButton.backgroundColor = .black
        sendButton.setTitle("ETH", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchDown)
        self.view.addSubview(sendButton)
        sendButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendButton.layer.masksToBounds = false
        sendButton.layer.cornerRadius = sendButton.frame.width / CGFloat(2)
    }
    
    func setBtcSendButton() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var y: CGFloat?
        if statusHeight == 20{
            y = UIScreen.main.bounds.height - 4.5*(tabBarController?.tabBar.frame.size.height)!
        } else {
            y = UIScreen.main.bounds.height - 3.5*(tabBarController?.tabBar.frame.size.height)!
        }
        let x = UIScreen.main.bounds.width/4
        sendBtcButton = UIButton(frame: CGRect(x: x*3 - 75, y: y!, width: 50, height: 50))
        sendBtcButton.backgroundColor = .black
        sendBtcButton.setTitle("BTC", for: .normal)
        sendBtcButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //sendButton.setImage(UIImage(named: "send"), for: .normal)
        sendBtcButton.addTarget(self, action: #selector(sendAction), for: .touchDown)
        self.view.addSubview(sendBtcButton)
        sendBtcButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendBtcButton.layer.masksToBounds = false
        sendBtcButton.layer.cornerRadius = sendBtcButton.frame.width / CGFloat(2)
    }
    
    @objc func sendAction() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        let popupVC = TransferNavigationViewController()
        present(popupVC, animated: true, completion: nil)
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
