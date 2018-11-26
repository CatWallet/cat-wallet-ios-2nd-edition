//
//  SendResultViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import BigInt
import Web3swift
import EthereumAddress

class SendResultViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var confirmButton: UIButton!
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    //let gasLimit = Web3.Utils.formatToEthereumUnits(transaction.transaction.gasLimit, toUnits: .eth, decimals: 16, decimalSeparator: ".")!
    let setButton = SetButton()
    var getFrom = ""
    var getTo = ""
    var totalPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton.setButton(confirmButton, 28)
        textView.isEditable = false
        textView.text = """
        From: \n
        \(getFrom) \n
        To: \n
        \(getTo) \n
        Total: \n
        \(totalPrice)
        """
        // Do any additional setup after loading the view.
    }

    @IBAction func confirmAction(_ sender: Any) {
        let vc = SendFinalResultViewController()
        
        do {
         
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            
        }
    }
    
//    func prepareTransactionForSendingEther(destinationAddressString: String,
//                                           amountString: String,
//                                           gasLimit: BigUInt) throws -> WriteTransaction {
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard let destinationEthAddress = EthereumAddress(destinationAddressString) else {throw SendErrors.invalidDestinationAddress}
//            guard let amount = Web3.Utils.parseToBigUInt(amountString, units: .eth) else {throw SendErrors.invalidAmountFormat}
//            guard let selectedKey = KeysService().selectedWallet()?.address else {throw SendErrors.noAvailableKeys}
//            let web3 = Web3.InfuraMainnetWeb3() //or any other network
//            web3.addKeystoreManager(KeysService().keystoreManager())
//            guard let ethAddressFrom = EthereumAddress(selectedKey) else {throw SendErrors.invalidKey}
//            guard let contract = web3.contract(Web3.Utils.coldWalletABI, at: destinationEthAddress, abiVersion: 2) else {throw SendErrors.invalidDestinationAddress}
//            guard let writeTX = contract.write("fallback") else {throw SendErrors.invalidContract}
//            writeTX.transactionOptions.from = ethAddressFrom
//            writeTX.transactionOptions.value = value
//            return writeTX
//        }
//    }
    

    
    public func writeTx(transaction: WriteTransaction,
                        options: TransactionOptions? = nil,
                        password: String? = nil) throws -> TransactionSendingResult {
        let options = options ?? transaction.transactionOptions
        guard let result = password == nil ?
            try? transaction.send() :
            try? transaction.send(password: password!, transactionOptions: options) else {throw Errors.wrongPassword}
        return result
    }
    
    public func callTxPlasma(transaction: ReadTransaction,
                             options: TransactionOptions? = nil) throws -> [String: Any] {
        let options = options ?? transaction.transactionOptions
        guard let result = try? transaction.call(transactionOptions: options) else {throw Errors.wrongPassword}
        return result
    }
    
//    func send() {
//        var options = Web3Options.defaultOptions()
////        var eip67Data = Web3.EIP67Code.init(address: EthereumAddress("0x6394b37Cf80A7358b38068f0CA4760ad49983a1B")!)
////        eip67Data.gasLimit = BigUInt(1)
////        eip67Data.amount = BigUInt("1")
////        //        eip67Data.data =
////        let encoding = eip67Data.toImage(scale: 10.0)
//
//        //Send on Rinkeby using normal keystore
//
//        let web3Rinkeby = Web3.InfuraRinkebyWeb3()
//        web3Rinkeby.addKeystoreManager(keystoreManager)
//        let coldWalletABI = "[{\"payable\":true,\"type\":\"fallback\"}]"
//        options = Web3Options.defaultOptions()
//        options.gasLimit = BigUInt(1)
//        options.from = EthereumAddress("0x60A5667f0b38e8EC0356cD1856B85E9798bE3098")
//        options.value = BigUInt(1)
//
//        let estimatedGasResult = web3Rinkeby.contract(coldWalletABI, at: coldWalletAddress)!.method(options: options)!.estimateGas(options: nil)
//        guard case .success(let estimatedGas) = estimatedGasResult else {return}
//        options.gasLimit = estimatedGas
//        var intermediateSend = web3Rinkeby.contract(coldWalletABI, at: coldWalletAddress, abiVersion: 2)!.method(options: options)!
//        let sendResult = intermediateSend.send(password: "BANKEXFOUNDATION")
//        //        let derivedSender = intermediateSend.transaction.sender
//        //        if (derivedSender?.address != sender.address) {
//        //            print(derivedSender!.address)
//        //            print(sender.address)
//        //            print("Address mismatch")
//        //        }
//        guard case .success(let sendingResult) = sendResult else {return}
//        let txid = sendingResult.hash
//        print("On Rinkeby TXid = " + txid)
//
//        //Send ETH on Rinkeby using BIP32 keystore. Should fail due to insufficient balance
//        web3Rinkeby.addKeystoreManager(bip32keystoreManager)
//        options.from = bip32ks?.addresses?.first!
//        intermediateSend = web3Rinkeby.contract(coldWalletABI, at: coldWalletAddress, abiVersion: 2)!.method(options: options)!
//        let sendResultBip32 = intermediateSend.send(password: "BANKEXFOUNDATION")
//        switch sendResultBip32 {
//        case .success(let r):
//            print(r)
//        case .failure(let err):
//            print(err)
//        }
//    }

}
