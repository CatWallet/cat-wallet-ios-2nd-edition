//
//  SendResultViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
//import Bigint
import Web3swift
//import EthereumAddress

class SendResultViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    var buttonConstraint: NSLayoutConstraint!
    var confirmButton: UIButton!
    var getFrom = ""
    var getTo = ""
    var totalPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfirmButton()
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

    @objc func confirmAction() {
        let vc = SendFinalResultViewController()
        
        do {
            navigationController?.pushViewController(vc, animated: true)
            } catch {
            
        }
    }
    
    func setConfirmButton() {
        confirmButton = UIButton(type: .custom)
        confirmButton.backgroundColor = .black
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.tintColor = .white
        self.view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchDown)
        confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonConstraint = confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(25 +  UIApplication.shared.statusBarFrame.size.height))
        buttonConstraint.isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.layoutIfNeeded()
        confirmButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        confirmButton.layer.masksToBounds = false
        confirmButton.layer.cornerRadius = confirmButton.frame.width / CGFloat(28)
        confirmButton.layer.borderWidth = 3.5
    }
    
    
    func sendtry() {
//        var options = Web3Options.defaultOptions()
//        options.gasLimit = BigUInt(21000)
//        options.from = EthereumAddress("0x60A5667f0b38e8EC0356cD1856B85E9798bE3098")
//        let amountDouble = Int((Double(2) ?? 0.0)*pow(10, 18))
//        let am = BigUInt.init(amountDouble)
//        options.value = am
//        let toaddress = EthereumAddress("0x0622074fc0a2faA152F0B3f6F4FAa4A7ef644741")
//        let estimatedGasResult = self.web3Rinkeby.contract(<#T##abiString: String##String#>, at: <#T##EthereumAddress?#>, abiVersion: <#T##Int#>)
//        //let estimatedGasResult = self.web3Rinkeby.contract(Web3.Utils.coldWalletABI, at: toaddress)!.method(options)!.estimateGas(options: nil)
//        guard case .success(let estimatedGas)? = estimatedGasResult else {return}
//        options.gasLimit = estimatedGas
//        var intermediateSend = self.web3Rinkeby.contract(Web3.Utils.coldWalletABI, at: toaddress, abiVersion: 2)!.method()
//        intermediateSend = self.web3Rinkeby.contract(Web3.Utils.coldWalletABI, at: toaddress, abiVersion: 2)!.method(options: options)!
//        let sendResult = intermediateSend?.send(password: "pass")
//        switch sendResult {
//        case .success(let r)?:
//        print("Sucess",r)
//        case .failure(let err)?:
//        print("Eroor",err)
//        case .none:
//        print("sendResultBip32",sendResult)
    }
    }
    

    


    



