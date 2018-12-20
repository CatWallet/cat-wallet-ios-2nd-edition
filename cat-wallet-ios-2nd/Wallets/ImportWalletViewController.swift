//
//  ImportWalletViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/7/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift

class ImportWalletViewController: UIViewController {

    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var phraseTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func createHDWallet(withName name: String?,
                        password: String, mnemonics: String,
                        completion: @escaping (KeyWalletModel?, Error?, String?) -> Void)
    {
        
        guard let keystore = try? BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            mnemonicsPassword: "",
            language: .english
            ),
            let wallet = keystore else {
                completion(nil, Errors.couldNotCreateKeystore, nil)
                return
        }
        guard let address = wallet.addresses?.first?.address else {
            completion(nil, Errors.couldNotCreateAddress, nil)
            return
        }
        guard let keyData = try? JSONEncoder().encode(wallet.keystoreParams) else {
            completion(nil, Errors.couldNotGetKeyData, nil)
            return
        }
        let walletModel = KeyWalletModel(address: address,
                                         data: keyData,
                                         name: name ?? "",
                                         isHD: true)
        //saveCurrentKeyStore(address: address, data: keyData, name: name ?? "", mnemonics: mnemonics)
        //saveKeyStore(wallet)
        //saveWalletModel(address: address, data: keyData, name: name ?? "", mnemonics: mnemonics)
        completion(walletModel, nil, mnemonics)
    }
    
    @IBAction func importAction(_ sender: Any) {
        createHDWallet(withName: "String", password: "Password", mnemonics: "Diary robust credit subway elite economy Author clever steak word bring mixture") { (_, error, _) in
            if error == nil {
                print("have it")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
