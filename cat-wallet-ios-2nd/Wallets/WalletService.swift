//
//  WalletsViewModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import Web3swift
import RealmSwift
import BitcoinKit
import EthereumAddress

struct WalletService {
    
    let btcWallet = BitcoinService()

    func generateMnemonics(bitsOfEntropy: Int) -> String? {
        guard let mnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy),
            let unwrapped = mnemonics else {
                return nil
        }
        return unwrapped
    }

    func createHDWallet(withName name: String?,
                        password: String,
                        completion: @escaping (KeyWalletModel?, Error?, String?, String?) -> Void)
    {
        
        guard let mnemonics = generateMnemonics(bitsOfEntropy: 128) else {
            completion(nil, Errors.couldNotGenerateMnemonics, nil, nil)
            return
        }
        
        guard let keystore = try? BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            mnemonicsPassword: "",
            language: .english
            ),
            let wallet = keystore else {
                completion(nil, Errors.couldNotCreateKeystore, nil, nil)
                return
        }
        guard let address = wallet.addresses?.first?.address else {
            completion(nil, Errors.couldNotCreateAddress, nil, nil)
            return
        }
        guard let keyData = try? JSONEncoder().encode(wallet.keystoreParams) else {
            completion(nil, Errors.couldNotGetKeyData, nil, nil)
            return
        }
        
        let btc = btcWallet.createBTCWallet(mnemonics)
        let btcAddress = btcWallet.getRecieveAddress(btc)
        let finalBtcAddress = btcAddress.replacingOccurrences(of: "bitcoincash:", with: "")
        let walletModel = KeyWalletModel(address: address, data: keyData, name: name ?? "", isHD: true)
        saveCurrentKeyStore(address: address, data: keyData, name: name ?? "", mnemonics: mnemonics, btcaddress: finalBtcAddress)
        saveKeyStore(wallet)
        saveWalletModel(address: address, data: keyData, name: name ?? "", mnemonics: mnemonics, btcaddress: finalBtcAddress)
        completion(walletModel, nil, mnemonics, finalBtcAddress)
    }

    func saveWalletModel(address: String, data: Data, name: String, mnemonics: String, btcaddress: String) {
        let realm = try! Realm()
        let ksRealm = KeyStoreRealm()
        ksRealm.walletName = "Wallet"
        ksRealm.address = address
        ksRealm.data = data
        ksRealm.name = name
        ksRealm.mnemonics = mnemonics
        ksRealm.btcaddress = btcaddress
        try! realm.write{
            realm.add(ksRealm)
        }
    }

    func saveCurrentKeyStore(address: String, data: Data, name: String, mnemonics: String, btcaddress: String) {
        let realm = try! Realm()
        let cksRealm = CurrentKeyStoreRealm()
        let ocksRealm = realm.objects(CurrentKeyStoreRealm.self)
        try! realm.write{
            realm.delete(ocksRealm)
        }
        cksRealm.walletName = "Wallet"
        cksRealm.address = address
        cksRealm.data = data
        cksRealm.name = name
        cksRealm.mnemonics = mnemonics
        cksRealm.btcaddress = btcaddress
        try! realm.write{
            realm.add(cksRealm)
        }
    }

    func getKeyStoreCount() -> Int{
        let realm = try! Realm()
        let wallet = realm.objects(KeyStoreRealm.self)
        return wallet.count
    }

    func fetchCurrenKeyStore() -> CurrentKeyStoreRealm{
        let realm = try! Realm()
        var cksRealm = CurrentKeyStoreRealm()
        let walletRealm = realm.objects(CurrentKeyStoreRealm.self)
        for i in walletRealm {
            cksRealm = i
        }
        return cksRealm
    }

    func saveKeyStore(_ ks: BIP32Keystore) {
        guard let userDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first,
            let keystoreManager = KeystoreManager.managerForPath(userDirectory + "/keystore")
            else {
                fatalError("Couldn't create a KeystoreManager.")
        }
        let newKeystoreJSON = try? JSONEncoder().encode(ks.keystoreParams)
        FileManager.default.createFile(atPath: "\(keystoreManager.path)/keystore.json", contents: newKeystoreJSON, attributes: nil)
    }

    func getKeyStoreManager(_ data: Data) throws ->KeystoreManager{
        guard let keystore = BIP32Keystore(data) else {
            if let defaultKeystore = KeystoreManager.defaultManager {
                return defaultKeystore
            } else {
                throw Web3Error.keystoreError(err: .invalidAccountError)
            }
        }
        return KeystoreManager([keystore])
    }

    func getBalance(_ keyStore: CurrentKeyStoreRealm) -> String{
        if let ethAdd = EthereumAddress(keyStore.address){
            var balance = ""
            do {
                let web3 = Web3.InfuraMainnetWeb3()
                let balancebigint = try web3.eth.getBalance(address: ethAdd)
                balance = String(describing: Web3.Utils.formatToEthereumUnits(balancebigint)!)
            } catch let error {
                print(error)
            }
            return balance
        } else {
            return ""
        }
    }
}
