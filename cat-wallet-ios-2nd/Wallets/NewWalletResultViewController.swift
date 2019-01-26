//
//  NewWalletResultViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/19/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import Eureka
import HexColors

class NewWalletResultViewController: FormViewController {

    var getAddress = ""
    var getMnemonics = ""
    var getBtcAddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        form +++ Section("Wallet address")
            <<< LabelRow(){
                $0.value = getAddress
                }.cellUpdate({ (cell, row) in
                    cell.imageView?.image = UIImage(named: "Group7")
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                })
            
            <<< LabelRow(){
                $0.value = getBtcAddress
                }.cellUpdate({ (cell, row) in
                    cell.imageView?.image = UIImage(named: "Group8")
                }).cellSetup({ (cell, row) in
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                })
         +++ Section(footer:"Your backup phrase is the only way to restore your wallet, you should keep it safe and never show it to other people.")
            
            <<< TextAreaRow() {
                $0.value = getMnemonics
                }.cellSetup({ (cell, row) in
                    cell.textView.font = .systemFont(ofSize: 20)
                    cell.textView.isEditable = false
                }).cellUpdate({ (cell, row) in
                    cell.textView.isEditable = false
                })
        
        +++ Section()
            <<< ButtonRow(){
                $0.title = "Done"
                }.cellSetup({ (cell, row) in
                    
                }).onCellSelection({ (cell, row) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
        
    }
}
