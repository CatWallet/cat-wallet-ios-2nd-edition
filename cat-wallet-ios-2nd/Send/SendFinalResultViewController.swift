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
    let ws = WalletService()
    let setButton = SetButton()
    var fetchks = CurrentKeyStoreRealm()
    var keyStore: KeystoreManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setButton.setButton(doneButton, 2)
       
    }

    @IBAction func doneAction(_ sender: Any) {
        retreiveKeyStore()
        
    }
    
    func retreiveKeyStore() {
        fetchks = ws.fetchCurrenKeyStore()
        do {
            let ks = try ws.getKeyStoreManager(fetchks.data!)
            keyStore = ks
            let act = try prepareSendEthTx(toAddress: "sddsd", value: "1.0", gasLimit: TransactionOptions.GasLimitPolicy.automatic, gasPrice: TransactionOptions.GasPricePolicy.automatic)
            let result = try sendTx(transaction: act, password: "Password")
            print(result.transaction.description)
        } catch let error{
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func prepareSendEthTx(toAddress: String,
                          value: String,
                          gasLimit: TransactionOptions.GasLimitPolicy = .automatic,
                          gasPrice: TransactionOptions.GasPricePolicy = .automatic) throws -> WriteTransaction {
//        guard let ethAddress = EthereumAddress("0x2DbB29b741Ec75B01973bEC782A998D4b231B3Bb") else {
//            throw Web3Error.dataError
//        }
        guard let ethAddress = EthereumAddress(toAddress) else {
            throw Web3Error.dataError
        }
        let web3 = Web3.InfuraMainnetWeb3()
        web3.addKeystoreManager(keyStore)
        guard let contract = web3.contract(Web3.Utils.coldWalletABI, at: ethAddress, abiVersion: 2) else {
            throw Web3Error.dataError
        }
        guard let ethAddressFrom = EthereumAddress(fetchks.address) else {throw Errors.invalidKey}
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        var options = web3.transactionOptions
        options.from = ethAddressFrom
        options.value = amount
        options.gasPrice = gasPrice
        options.gasLimit = gasLimit
        guard let transaction = contract.method("fallback",parameters: [AnyObject](),extraData: Data(),transactionOptions: options) else { throw Web3Error.transactionSerializationError
        }
        return transaction
    }
    
    func sendTx(transaction: WriteTransaction,
                options: TransactionOptions? = nil,
                password: String) throws -> TransactionSendingResult {
        do {
            let txOptions = options ?? transaction.transactionOptions
            let result = try transaction.send(password: password, transactionOptions: txOptions)
            dismiss(animated: false, completion: nil)
            return result
        } catch let error {
            print(error)
            print(error.localizedDescription)
            throw error
        }
    }
    
    func getPendingTransaction() {
        //web3.txPool.getStatus()
    }
}


    


