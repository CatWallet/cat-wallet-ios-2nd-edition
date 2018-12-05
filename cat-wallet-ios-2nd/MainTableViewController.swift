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
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var buttonConstraint: NSLayoutConstraint!
    var sendButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "SendTableViewCell", bundle: nil), forCellReuseIdentifier: "sendCoinCell")
        setSendButton()
        keyStore = ws.fetchCurrenKeyStore()
        self.tableView.tableFooterView = UIView()
        title = "Main"
        shownotibar.showBar(title: "", subtitle: "message", style: .success)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if walletDetect() {
            sendButton.isHidden = false
            tableView.backgroundColor = UIColor.white
            return 1
        } else {
            //            let backgroundImage = UIImage(named: "address")
            //            let imageView = UIImageView(image: backgroundImage)
            //            tableView.backgroundView = imageView
            sendButton.isHidden = true
            tableView.backgroundColor = UIColor.black
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sendCoinCell", for: indexPath) as! SendTableViewCell
        cell.coinNum.text = "x" + ws.getBalance(keyStore)
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
    
    func setSendButton() {
        let y = UIScreen.main.bounds.height - 3.5*(tabBarController?.tabBar.frame.size.height)!
        let x = UIScreen.main.bounds.width/4
        sendButton = UIButton(frame: CGRect(x: x*3, y: y, width: 70, height: 70))
        sendButton.backgroundColor = .black
        sendButton.setImage(UIImage(named: "send"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchDown)
        self.view.addSubview(sendButton)
        sendButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendButton.layer.masksToBounds = false
        sendButton.layer.cornerRadius = sendButton.frame.width / CGFloat(2)
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
