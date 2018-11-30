//
//  WalletsViewModel.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 10/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import web3swift
import RealmSwift

func generateMnemonics(bitsOfEntropy: Int) -> String? {
    guard let mnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy),
        let unwrapped = mnemonics else {
            return nil
    }
    return unwrapped
}

func createHDWallet(withName name: String?,
                    password: String,
                    completion: @escaping (KeyWalletModel?, Error?, String?) -> Void)
{
    
    guard let mnemonics = generateMnemonics(bitsOfEntropy: 128) else {
        completion(nil, Errors.couldNotGenerateMnemonics, nil)
        return
    }
    
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
    saveKeyStore(address: address, data: keyData, name: name ?? "")
    completion(walletModel, nil, mnemonics)
}

func saveKeyStore(address: String, data: Data, name: String) {
    let realm = try! Realm()
    let ksRealm = KeyStoreRealm()
    ksRealm.address = address
    ksRealm.data = data
    ksRealm.name = name
    try! realm.write{
        realm.add(ksRealm)
    }
}

func saveCurrentKeyStore(address: String, data: Data, name: String) {
    let realm = try! Realm()
    let cksRealm = CurrentKeyStoreRealm()
    let ocksRealm = realm.objects(CurrentKeyStoreRealm.self)
    try! realm.write{
        realm.delete(ocksRealm)
    }
    cksRealm.address = address
    cksRealm.data = data
    cksRealm.name = name
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
