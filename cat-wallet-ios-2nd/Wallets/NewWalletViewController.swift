//
//  NewWalletViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift

class NewWalletViewController: UIViewController {
    @IBOutlet weak var newWalletButton: UIButton!
    @IBOutlet weak var importWalletButton: UIButton!
    let ws = WalletService()
    let setButton = SetButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton.setButton(newWalletButton, 2)
        setButton.setButton(importWalletButton, 2)
        
    }
    
    @IBAction func createNewWallet(_ sender: Any) {
        ws.createHDWallet(withName: "String", password: "Password") { (keyWallet, error, mnemonics, btcAddress) in
            if error != nil {
                print(error as! String)
            } else {
                let vc = SuccessCreationViewController()
                vc.getAddress = keyWallet?.address ?? ""
                vc.getMnemonics = mnemonics ?? ""
                vc.getBtcAddress = btcAddress ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
