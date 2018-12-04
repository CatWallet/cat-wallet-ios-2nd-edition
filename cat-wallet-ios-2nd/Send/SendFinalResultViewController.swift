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
    var fetchks = CurrentKeyStoreRealm()
    var keyStore: KeystoreManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setButton.setButton(doneButton, 2)
        retreiveKeyStore()
       
    }

    @IBAction func doneAction(_ sender: Any) {
        retreiveKeyStore()

    }
    

    
    func retreiveKeyStore() {
        fetchks = fetchCurrenKeyStore()
        do {
            let ks = try getKeyStoreManager(fetchks.data!)
            keyStore = ks
            let act = try prepareTransactionForSendingEther()
            let result = try sendTx(transaction: act, password: "Password")
            print(result)
        } catch {
            
        }
        
    }
    
    func prepareTransactionForSendingEther() throws -> WriteTransaction {
        //DispatchQueue.global(qos: .userInitiated).async {
            guard let destinationEthAddress = EthereumAddress("0x60A5667f0b38e8EC0356cD1856B85E9798bE3098") else {throw Errors.invalidDestinationAddress}
            guard let amount = Web3.Utils.parseToBigUInt("1", units: .eth) else {throw Errors.invalidAmountFormat}
        
            let web3 = Web3.InfuraRinkebyWeb3()
            web3.addKeystoreManager(keyStore)
            guard let ethAddressFrom = EthereumAddress(fetchks.address) else {throw Errors.invalidKey}
            guard let contract = web3.contract(Web3.Utils.coldWalletABI, at: destinationEthAddress, abiVersion: 2) else {throw Errors.invalidDestinationAddress}
            guard let writeTX = contract.write("fallback") else {throw Errors.invalidContract}
            writeTX.transactionOptions.from = ethAddressFrom
            writeTX.transactionOptions.value = amount
            return writeTX
        }
    
//    func prepareSendEthTx(toAddress: String,
//                          value: String = "1.0",
//                          gasLimit: TransactionOptions.GasLimitPolicy = .automatic,
//                          gasPrice: TransactionOptions.GasPricePolicy = .automatic) throws -> WriteTransaction {
//        guard let ethAddress = EthereumAddress(toAddress) else {
//            throw Web3Error.dataError
//        }
//        guard let contract = web3Instance.contract(Web3.Utils.coldWalletABI, at: ethAddress, abiVersion: 2) else {
//            throw Web3Error.dataError
//        }
//        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
//        var options = defaultOptions()
//        options.value = amount
//        options.gasPrice = gasPrice
//        options.gasLimit = gasLimit
//        guard let tx = contract.write("fallback",
//                                      parameters: [AnyObject](),
//                                      extraData: Data(),
//                                      transactionOptions: options) else {
//                                        throw Web3Error.transactionSerializationError
//        }
//        return tx
//    }
    
    func sendTx(transaction: WriteTransaction,
                options: TransactionOptions? = nil,
                password: String) throws -> TransactionSendingResult {
        do {
            let txOptions = options ?? transaction.transactionOptions
            let result = try transaction.send(password: password, transactionOptions: txOptions)
            return result
        } catch let error {
            print(error.localizedDescription)
            throw error
        }
    }
    func callTx(transaction: ReadTransaction,
                options: TransactionOptions? = nil) throws -> [String : Any] {
        do {
            let txOptions = options ?? transaction.transactionOptions
            let result = try transaction.call(transactionOptions: txOptions)
            return result
        } catch let error {
            throw error
        }
    }
}


    


