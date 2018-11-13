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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createNewWallet(_ sender: Any) {
////        let alert = UIAlertController(title: "Enter Passphrase", message: nil, preferredStyle: .alert)
////        alert.addTextField(configurationHandler: {
////            (textfield) in
////            textfield.placeholder = "Enter Password"
////        })
////        let genrate = UIAlertAction(title: "Genrate", style: .destructive, handler: {
////            _ in
////            let pass = alert.textFields![0].text
////            if pass != ""{
////                //do{
//                    let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//                    let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
//                    var ks: BIP32Keystore?
//                    if (keystoreManager?.addresses?.count == 0) {
//                        let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 256)!
//                        let keystore = try! BIP32Keystore(mnemonics: mnemonic, password: "somepassword", mnemonicsPassword: String((pass ?? "").reversed()))
//                        ks = keystore
//                        let keydata = try JSONEncoder().encode(ks?.keystoreParams)
//                        FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
//                    } else {
//                        ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as? BIP32Keystore
//                    }
//                    guard let sender = ks?.addresses?.first else {return}
//                    print(sender)
//
////                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
////                    self.present(controller!, animated: true, completion: nil)
//
//            //}else{
//                print("cdsfdfdf")
//                self.dismiss(animated: true, completion: nil)
//                //self.present(alert, animated: true, completion: nil)
//            }
//
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addAction(genrate)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
    }
}
