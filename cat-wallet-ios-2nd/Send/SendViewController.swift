//
//  SendViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SendViewController: UIViewController {
  
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    var addressField = SkyFloatingLabelTextField()
    var amountField = SkyFloatingLabelTextField()
    var cKeyStore = CurrentKeyStoreRealm()
    let setButton = SetButton()
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Send"
        setFloatTextField()
        getKeyStore()
        setButton.setButton(sendButton, 2)
        setButton.setButton(clearButton, 2)
        print(cKeyStore.address)
    }
    
    func getKeyStore() {
        cKeyStore = fetchCurrenKeyStore()
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        let popupVC = ContactsViewController()
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func clearAction(_ sender: Any) {
        addressField.text = nil
        amountField.text = nil
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if addressField.text != "" || amountField.text != "" {
            let vc = SendResultViewController()
            vc.getFrom = cKeyStore.address
            vc.getTo = addressField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setFloatTextField() {
        let width = UIScreen.main.bounds.size.width - 40
        let AddressTextFieldFrame = CGRect(x: 20, y: 100, width: width, height: 60)
        let amountTextFieldFrame = CGRect(x: 20, y: 180, width: width, height: 60)
        
        addressField = SkyFloatingLabelTextFieldWithIcon(frame: AddressTextFieldFrame)
        addressField.placeholder = "ETH address"
        addressField.title = "ETH address"
        self.view.addSubview(addressField)
        
        amountField = SkyFloatingLabelTextFieldWithIcon(frame: amountTextFieldFrame)
        amountField.placeholder = "ETH amount"
        amountField.title = "ETH amount"
        self.view.addSubview(amountField)
    }
}
