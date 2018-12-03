//
//  SendFinalResultViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Web3swift
import EthereumAddress
import BigInt

enum Result<T> {
    case Success(T)
    case Error(Error)
}

class SendFinalResultViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    let setButton = SetButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setButton.setButton(doneButton, 2)
       
    }

    @IBAction func doneAction(_ sender: Any) {
        send()
//        preparePostPeepTransaction { (result) in
//            switch result {
//            case .Success:
//                print("made it")
//            case .Error:
//                print("error")
//            }
//        }
        //dismiss(animated: true, completion: nil)
    }
    
//    func getPrivateKey(forWallet wallet: KeyWalletModel, password: String) -> String? {
//        do {
//            guard let ethereumAddress = EthereumAddress(wallet.address) else { return nil }
//            let pkData = try KeystoreManager().UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress)
//            return pkData.toHexString()
//        } catch {
//            print(error)
//            return nil
//        }
//    }
            
    
    func send() {
        createHDWallet(withName: "catwallet", password: "catwallet") { (wallet, error, mnemonics) in
            if error != nil {
                print(error as! String)
            } else {
                guard let userDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first,
                    let keystoreManager = KeystoreManager.managerForPath(userDirectory + "/keystore")
                    else {
                        fatalError("Couldn't create a KeystoreManager.")
                }
                
                // Next you create a new Keystore:
                
                let newKeystore = try? EthereumKeystoreV3(password: "YOUR_PASSWORD")
                print(newKeystore!!)
                
                // Then you save the created keystore to the file system:
                
                let newKeystoreJSON = try? JSONEncoder().encode(newKeystore!!.keystoreParams)
                FileManager.default.createFile(atPath: "\(keystoreManager.path)/keystore.json", contents: newKeystoreJSON, attributes: nil)
            }
        }
        
     }
}
