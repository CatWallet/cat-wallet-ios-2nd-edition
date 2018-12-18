//
//  WalletsTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import RealmSwift

protocol ReloadTableView {
    func reloadTableView(_ message: String)
}

class WalletsTableViewController: UITableViewController {
    
    var wallets:[KeyStoreRealm] = []
    let ws = WalletService()
    var delegate: ReloadTableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wallets = []
        fetchWallet()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletsCell")
        cell?.textLabel?.adjustsFontSizeToFitWidth = true
        cell?.textLabel?.text = wallets[indexPath.row].address
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let keyStore = wallets[index]
        ws.saveCurrentKeyStore(address: keyStore.address, data: keyStore.data!, name: keyStore.name, mnemonics: keyStore.mnemonics)
        dismiss(animated: true) {
            self.delegate?.reloadTableView("pass a message")
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteWallet(self.wallets[indexPath.row].address)
            self.wallets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }
        return [delete]
    }
}
