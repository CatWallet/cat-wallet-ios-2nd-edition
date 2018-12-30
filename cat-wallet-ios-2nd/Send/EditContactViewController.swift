//
//  EditContactViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/29/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SkyFloatingLabelTextField

class EditContactViewController: BottomPopupViewController {
    
    let contactService = ContactsService()
    weak var delegate: PassNewContact?
    var contact = Contact()
    var nameField = SkyFloatingLabelTextField()
    var addressField = SkyFloatingLabelTextField()
    var BTCAddressField = SkyFloatingLabelTextField()
    var emailField = SkyFloatingLabelTextField()
    var phoneField = SkyFloatingLabelTextField()
    var getName = ""
    var getAddress = ""
    var getBTCAddress = ""
    var getEmail = ""
    var getPhone = ""
    var getID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        setFloatTextField()
        initTextField()
    }
    
    func initTextField() {
        nameField.text = getName
        addressField.text = getAddress
        BTCAddressField.text = getBTCAddress
        emailField.text = getEmail
        phoneField.text = getPhone
    }
    
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Edit contact")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(editContact))
        doneItem.tintColor = UIColor.black
        let dismiss = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: nil, action: #selector(dismissAction))
        dismiss.tintColor = UIColor.black
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = dismiss
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editContact() {
        if nameField.text != "" && addressField.text != ""{
            contactService.updateContact(nameField.text!, addressField.text!, BTCAddressField.text ?? "", emailField.text ?? "", Int(phoneField.text ?? "") ?? 0, getID)
            self.dismiss(animated: true)
        } else {
            let alertController = UIAlertController(title: "", message: "Please enter a name and ETH address", preferredStyle: .alert)
            let action = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: false, completion: nil)
        }
    }
    
    func setFloatTextField() {
        let width = UIScreen.main.bounds.size.width - 40
        let NameTextFieldFrame = CGRect(x: 20, y: 60, width: width, height: 60)
        let AddressTextFieldFrame = CGRect(x: 20, y: 120, width: width, height: 60)
        let BTCAddressTextFieldFrame = CGRect(x: 20, y: 180, width: width, height: 60)
        let EmailTextFieldFrame = CGRect(x: 20, y: 240, width: width, height: 60)
        let PhoneTextFieldFrame = CGRect(x: 20, y: 300, width: width, height: 60)
        
        nameField = SkyFloatingLabelTextFieldWithIcon(frame: NameTextFieldFrame)
        nameField.placeholder = "Name"
        nameField.title = "Name"
        nameField.keyboardType = .default
        nameField.autocapitalizationType = .none
        nameField.autocorrectionType = .no
        nameField.isUserInteractionEnabled = false
        self.view.addSubview(nameField)
        
        addressField = SkyFloatingLabelTextFieldWithIcon(frame: AddressTextFieldFrame)
        addressField.placeholder = "ETH address"
        addressField.title = "ETH address"
        addressField.keyboardType = .default
        addressField.autocapitalizationType = .none
        addressField.autocorrectionType = .no
        addressField.adjustsFontSizeToFitWidth = true
        self.view.addSubview(addressField)
        
        BTCAddressField = SkyFloatingLabelTextFieldWithIcon(frame: BTCAddressTextFieldFrame)
        BTCAddressField.placeholder = "BTC address"
        BTCAddressField.title = "BTC address"
        BTCAddressField.keyboardType = .default
        BTCAddressField.autocapitalizationType = .none
        BTCAddressField.autocorrectionType = .no
        BTCAddressField.adjustsFontSizeToFitWidth = true
        self.view.addSubview( BTCAddressField)
        
        emailField = SkyFloatingLabelTextFieldWithIcon(frame: EmailTextFieldFrame)
        emailField.placeholder = "Email"
        emailField.title = "Email"
        emailField.keyboardType = .default
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        self.view.addSubview(emailField)
        
        phoneField = SkyFloatingLabelTextFieldWithIcon(frame: PhoneTextFieldFrame)
        phoneField.placeholder = "Phone"
        phoneField.title = "Phone"
        phoneField.keyboardType = .numberPad
        self.view.addSubview(phoneField)
    }
    
    override func getPopupHeight() -> CGFloat {
        let stHeight = UIApplication.shared.statusBarFrame.size.height
        let scHeight = UIScreen.main.bounds.size.height
        let height = Int(scHeight) - Int(stHeight*3)
        return CGFloat(height)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return CGFloat(35)
    }
    
    override func getPopupPresentDuration() -> Double {
        return 0.3
    }
    
    override func getPopupDismissDuration() -> Double {
        return 0.3
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }

}
