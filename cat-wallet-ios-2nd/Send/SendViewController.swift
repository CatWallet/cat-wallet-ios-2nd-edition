//
//  SendViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import EthereumAddress
import QRCodeReaderViewController
import SkyFloatingLabelTextField


class SendViewController: UIViewController, PassContactData, QRCodeReaderDelegate {

    @IBOutlet weak var contactButton: UIButton!
    var addressField = SkyFloatingLabelTextField()
    var amountField = SkyFloatingLabelTextField()
    var cKeyStore = CurrentKeyStoreRealm()
    let ws = WalletService()
    let notification = ShowNotiBar()
    var sendButton: UIButton!
    var buttonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        setFloatTextField()
        getKeyStore()
        setFloatButton()
        setQRButton()
        hideNavigationBar()
        setCleanButton()
        setAmountToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getKeyStore()
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setQRButton() {
        let QRbutton = UIButton(frame: CGRect(x: 310, y: 205, width: 25, height: 25))
        QRbutton.setImage(UIImage(named: "qr_icon"), for: .normal)
        QRbutton.setTitle("Tap me", for: .normal)
        QRbutton.tintColor = UIColor.black
        QRbutton.addTarget(self, action: #selector(QRAction), for: .touchUpInside)
        self.view.addSubview(QRbutton)
    }
    
    @objc func QRAction() {
        let vc = QRCodeReaderViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func setFloatButton() {
        sendButton = UIButton(type: .custom)
        sendButton.backgroundColor = .black
        sendButton.setTitle("Send", for: .normal)
        sendButton.tintColor = .white
        self.view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonConstraint = sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(25 +  UIApplication.shared.statusBarFrame.size.height))
        buttonConstraint.isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.layoutIfNeeded()
        subscribeToShowKeyboardNotifications()
        sendButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendButton.layer.masksToBounds = false
        sendButton.layer.cornerRadius = sendButton.frame.width / CGFloat(28)
        sendButton.layer.borderWidth = 3.5
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        buttonConstraint.constant = -(25 +  UIApplication.shared.statusBarFrame.size.height) - keyboardHeight
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonConstraint.constant = -(25 +  UIApplication.shared.statusBarFrame.size.height)
        let userInfo = notification.userInfo
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func buttonAction() {
        if let _ = EthereumAddress(addressField.text!), let amount = amountField.text{
            if addressField.text != "" || amountField.text != "" {
                let vc = SendResultViewController()
                vc.getFrom = cKeyStore.address
                vc.getTo = addressField.text!
                vc.totalPrice = amount
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            notification.showBar(title: "Not a vaild Ethereum address or amount", subtitle: "", style: .danger)
        }
    }
    
    func getKeyStore() {
        cKeyStore = ws.fetchCurrenKeyStore()
    }
    
    func passContact(_ address: String) {
        addressField.text = address
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        let popupVC = ContactsViewController()
        popupVC.delegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController!) {
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
    }
    
    
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        reader.stopScanning()
        reader.dismiss(animated: true) { [weak self] in
            self!.amountField.becomeFirstResponder()
            self?.addressField.text = result
        }
        
        
    }
    
    func setCleanButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let dismissButton = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dissKeyboard))
        let leftSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let rightSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let emptyButton = UIBarButtonItem(title: "Empty", style: .done, target: self, action: #selector(clearAddressField))
        let pasteButton = UIBarButtonItem(title: "Paste", style: .done, target: self, action: #selector(pasteToAddressField))
        toolbar.setItems([emptyButton,leftSpace ,dismissButton,rightSpace ,pasteButton], animated: false)
        addressField.inputAccessoryView = toolbar
    }
    
    func setAmountToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let dismissButton = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dissKeyboard))
        let leftSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let rightSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        //let emptyButton = UIBarButtonItem(title: "Empty", style: .done, target: self, action: #selector(clearAddressField))
        //let pasteButton = UIBarButtonItem(title: "Paste", style: .done, target: self, action: #selector(pasteToAddressField))
        toolbar.setItems([leftSpace ,dismissButton,rightSpace], animated: false)
        amountField.inputAccessoryView = toolbar
    }
    
    @objc func clearAddressField() {
        addressField.text = ""
    }
    
    @objc func pasteToAddressField() {
        if let address = UIPasteboard.general.string {
            addressField.insertText(address)
        }
    }
    
    @objc func dissKeyboard() {
        view.endEditing(true)
    }
    
    func setFloatTextField() {
        let width = UIScreen.main.bounds.size.width - 40
        let AddressTextFieldFrame = CGRect(x: 20, y: 45, width: width, height: 60)
        let amountTextFieldFrame = CGRect(x: 20, y: 115, width: width, height: 60)
        addressField = SkyFloatingLabelTextFieldWithIcon(frame: AddressTextFieldFrame)
        addressField.placeholder = "ETH address"
        addressField.title = "ETH address"
        addressField.keyboardType = .default
        addressField.autocapitalizationType = .none
        addressField.autocorrectionType = .no
        addressField.adjustsFontSizeToFitWidth = true
        self.view.addSubview(addressField)
        amountField = SkyFloatingLabelTextFieldWithIcon(frame: amountTextFieldFrame)
        amountField.placeholder = "Amount"
        amountField.title = "Amount"
        amountField.keyboardType = .numberPad
        self.view.addSubview(amountField)
    }
}

extension SendViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SendViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
