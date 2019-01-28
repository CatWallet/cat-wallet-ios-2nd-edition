//
//  WalletsTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import HexColors
import RealmSwift

protocol ReloadTableView {
    func reloadTableView(_ message: String)
}

class WalletsTableViewController: UITableViewController {
    
    var wallets:[KeyStoreRealm] = []
    let ws = WalletService()
    var keyStore = CurrentKeyStoreRealm()
    var delegate: ReloadTableView?
    let shownotibar = ShowNotiBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        UINavigationBar.appearance().tintColor = .white
        keyStore = ws.fetchCurrenKeyStore()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Wallets"
        wallets = []
        fetchWallet()
        tableView.reloadData()
        tableView.tableFooterView = nil
    }
    
    func fetchWallet() {
        let realm = try! Realm()
        let walletRealm = realm.objects(KeyStoreRealm.self)
        for i in walletRealm {
            wallets.append(i)
        }
    }
    
    func deleteWallet(_ address: String) {
        let realm = try! Realm()
        let walletRealm = realm.objects(KeyStoreRealm.self).filter("address == '\(address)'")
        try! realm.write {
            realm.delete(walletRealm)
        }
    }
    
    @IBAction func popViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = ws.getKeyStoreCount()
        return num
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletsCell") as! WalletsTableViewCell
        cell.walletButton.tag = indexPath.row
        cell.walletButton.addTarget(self, action: #selector(walletDetailButton), for: .touchUpInside)
        if keyStore.address == wallets[indexPath.row].address {
            cell.walletButton.setImage(UIImage(named: "wallet_selection_2"), for: .normal)
        }
        cell.walletName.text = wallets[indexPath.row].walletName
        return cell
    }
    
    @objc func walletDetailButton(sender: UIButton) {
        let vc = WalletInfoViewController()
        vc.getWalletName = self.wallets[sender.tag].walletName
        vc.getAddress = self.wallets[sender.tag].address
        vc.getBtcAddress = self.wallets[sender.tag].btcaddress
        vc.getMnemonics = self.wallets[sender.tag].mnemonics
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let keyStore = wallets[index]
        ws.saveCurrentKeyStore(WalletName: keyStore.walletName, address: keyStore.address, data: keyStore.data!, name: keyStore.name, mnemonics: keyStore.mnemonics, btcaddress: keyStore.btcaddress)
        dismiss(animated: true) {
            self.delegate?.reloadTableView("pass a message")
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if self.keyStore.address == self.wallets[indexPath.row].address{
                self.shownotibar.showBar(title: "This wallet is currently in use", subtitle: "", style: .warning)
                return
            }
            
            self.deleteWallet(self.wallets[indexPath.row].address)
            self.wallets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                
        }
        return [delete]
    }
}
