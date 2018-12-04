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

    }
    }
    

    


    



