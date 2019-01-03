//
//  BitcoinService.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/22/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import BitcoinKit

var cryptoName = ""

struct BitcoinService {
    var peerGroup: PeerGroup?
    var payments = [Payment]()
    
    func createBTCWallet(_ mnemonic: String) -> HDWallet{
        let mnemonicList = mnemonic.components(separatedBy: " ")
            let seed = Mnemonic.seed(mnemonic: mnemonicList)
            let wallet = HDWallet(seed: seed, network: .mainnetBTC)
            return wallet
    }
    
    func getRecieveAddress(_ wallet: HDWallet) -> String {
        var btcAddress = ""
        do {
            let address = try wallet.receiveAddress()
            btcAddress = address.base58
       } catch let error {
            print(error.localizedDescription)
        }
        return btcAddress
    }
    
    func selectTx(from utxos: [UnspentTransaction], amount: Int64) -> (utxos: [UnspentTransaction], fee: Int64) {
        return (utxos, 500)
    }
    
    public func createUnsignedTx(toAddress: Address, amount: Int64, changeAddress: Address, utxos: [UnspentTransaction]) -> UnsignedTransaction {
        let (utxos, fee) = selectTx(from: utxos, amount: amount)
        let totalAmount: Int64 = utxos.reduce(0) { $0 + $1.output.value }
        let change: Int64 = totalAmount - amount - fee
        
        let toPubKeyHash: Data = toAddress.data
        let changePubkeyHash: Data = changeAddress.data
        
        let lockingScriptTo = Script.buildPublicKeyHashOut(pubKeyHash: toPubKeyHash)
        let lockingScriptChange = Script.buildPublicKeyHashOut(pubKeyHash: changePubkeyHash)
        
        let toOutput = TransactionOutput(value: amount, lockingScript: lockingScriptTo)
        let changeOutput = TransactionOutput(value: change, lockingScript: lockingScriptChange)
        
        let unsignedInputs = utxos.map { TransactionInput(previousOutput: $0.outpoint, signatureScript: Data(), sequence: UInt32.max) }
        let tx = Transaction(version: 1, inputs: unsignedInputs, outputs: [toOutput, changeOutput], lockTime: 0)
        return UnsignedTransaction(tx: tx, utxos: utxos)
    }
    
    func signTx(unsignedTx: UnsignedTransaction, keys: [PrivateKey]) -> Transaction {
        var inputsToSign = unsignedTx.tx.inputs
        var transactionToSign: Transaction {
            return Transaction(version: unsignedTx.tx.version, inputs: inputsToSign, outputs: unsignedTx.tx.outputs, lockTime: unsignedTx.tx.lockTime)
        }
        
        let hashType = SighashType.BTC.ALL
        for (i, utxo) in unsignedTx.utxos.enumerated() {
            let pubkeyHash: Data = Script.getPublicKeyHash(from: utxo.output.lockingScript)
            
            let keysOfUtxo: [PrivateKey] = keys.filter { $0.publicKey().pubkeyHash == pubkeyHash }
            guard let key = keysOfUtxo.first else {
                print("No keys to this txout : \(utxo.output.value)")
                continue
            }
            print("Value of signing txout : \(utxo.output.value)")
            
            let sighash: Data = transactionToSign.signatureHash(for: utxo.output, inputIndex: i, hashType: SighashType.BTC.ALL)
            let signature: Data = try! Crypto.sign(sighash, privateKey: key)
            let txin = inputsToSign[i]
            let pubkey = key.publicKey()
            
            let unlockingScript = Script.buildPublicKeyUnlockingScript(signature: signature, pubkey: pubkey, hashType: hashType)
        
            inputsToSign[i] = TransactionInput(previousOutput: txin.previousOutput, signatureScript: unlockingScript, sequence: txin.sequence)
        }
        return transactionToSign
    }
}
