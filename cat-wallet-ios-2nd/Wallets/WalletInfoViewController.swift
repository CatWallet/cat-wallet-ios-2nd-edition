//
//  WalletInfoViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/26/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class WalletInfoViewController: FormViewController {
    
    var getAddress = ""
    var getBtcAddress = ""
    var getWalletName = ""
    var getMnemonics = ""
    let shownotibar = ShowNotiBar()
    let ws = WalletService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        form +++ Section(header: "Wallet name", footer: "Wallet name can be edit here")
            <<< TextRow("walletName") {
                $0.value = getWalletName
        }
        
        form +++ Section("Wallet address" )
            <<< LabelRow(){
                $0.value = getAddress
                }.cellUpdate({ (cell, row) in
                    cell.imageView?.image = UIImage(named: "Group7")
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    //cell.textLabel?.adjustsFontSizeToFitWidth = true
                })
            
            <<< LabelRow(){
                $0.value = getBtcAddress
                }.cellUpdate({ (cell, row) in
                    cell.imageView?.image = UIImage(named: "Group8")
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    //cell.textLabel?.adjustsFontSizeToFitWidth = true
                })
        
        form +++ Section("Backup phrase")
            <<< SwitchRow("switchRowTag"){
                $0.title = "Show backup phrase"
            }
            <<< TextAreaRow(){
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.value = getMnemonics
                }.cellSetup({ (cell, row) in
                    cell.textView.font = .systemFont(ofSize: 20)
                    cell.textView.isEditable = false
                }).cellUpdate({ (cell, row) in
                    cell.textView.isEditable = false
                })
            <<< ButtonRow(){
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Copy"
                }.onCellSelection({ (_, _) in
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = self.getMnemonics
                    if pasteboard.string != nil {
                        self.shownotibar.showBar(title: "Copied", subtitle: "", style: .success)
                    }
                })
        
    }
    
    func setUI() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Wallet Info"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
    }
    
    @objc func saveTapped() {
        let realm = try! Realm()
        let walletRealm = realm.objects(KeyStoreRealm.self).filter("address == '\(getAddress)'").first
        if let nameRow: TextRow = form.rowBy(tag: "walletName"){
            try! realm.write{
                walletRealm?.walletName = nameRow.value ?? "Wallet"
            }
            navigationController?.popViewController(animated: true)
        }
    }

}
