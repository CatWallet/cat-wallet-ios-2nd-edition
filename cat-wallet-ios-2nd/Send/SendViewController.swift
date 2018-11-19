//
//  SendViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
  
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    var cKeyStore = CurrentKeyStoreRealm()
    let setButton = SetButton()
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Send"
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
}
