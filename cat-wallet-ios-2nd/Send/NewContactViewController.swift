//
//  NewContactViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Parse
import PhoneNumberKit
import SkyFloatingLabelTextField

protocol PassNewContact: class{
    func passContact(_ contact: Contact)
}

class NewContactViewController: BottomPopupViewController, UISearchBarDelegate{
    
    
    @IBOutlet weak var addressSerachBar: UISearchBar!
    var nameField = SkyFloatingLabelTextField()
    var addressField = SkyFloatingLabelTextField()
    var emailField = SkyFloatingLabelTextField()
    var phoneField = SkyFloatingLabelTextField()
    let contactService = ContactsService()
    var contact = Contact()
    var isEmail: Bool?
    weak var delegate: PassNewContact?
    let phoneNumberKit = PhoneNumberKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setFloatTextField()
        setSearvhBar()
    }
    
    func setSearvhBar() {
        addressSerachBar.delegate = self
        addressSerachBar.keyboardType = .default
        addressSerachBar.autocapitalizationType = .none
        addressSerachBar.autocorrectionType = .no
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let message = searchBar.text {
            getAddress(message)
        }
    }
    
    func getAddress(_ message: String) {
        var params = [String: String]()
        if message.isEmail {
            isEmail = true
            params["email"] = message
        } else {
            do {
                let num = try phoneNumberKit.parse( message )
                let phoneNum = phoneNumberKit.format(num, toType: .e164)
                params["phone"] = phoneNum
                isEmail = false
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            let requestAddress = try PFCloud.callFunction("queryAddress", withParameters: params)
            addressField.text = requestAddress as? String
            if isEmail! {
                emailField.text = message
            } else {
                phoneField.text = message
            }
        } catch {
            let alert = UIAlertController(title: "", message: "No user found", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            print(error.localizedDescription)
        }
    }
    
    
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Add contact")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(addContact))
        let dismiss = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(dismissAction))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = dismiss
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addContact() {
        if nameField.text != "" && addressField.text != ""{
            contactService.saveContact(nameField.text!, addressField.text!, emailField.text ?? "", Int(phoneField.text ?? "") ?? 0)
            self.dismiss(animated: true) {
                self.contact.name = self.nameField.text!
                self.contact.address = self.addressField.text!
                self.contact.email = self.emailField.text ?? ""
                self.contact.phone = Int(self.phoneField.text ?? "") ?? 0
                self.delegate?.passContact(self.contact)
            }
        } else {
            let alertController = UIAlertController(title: "", message: "Please enter a name and ETH address", preferredStyle: .alert)
            let action = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: false, completion: nil)
        }
    }
    
    func setFloatTextField() {
        let width = UIScreen.main.bounds.size.width - 40
        let NameTextFieldFrame = CGRect(x: 20, y: 100, width: width, height: 60)
        let AddressTextFieldFrame = CGRect(x: 20, y: 160, width: width, height: 60)
        let EmailTextFieldFrame = CGRect(x: 20, y: 220, width: width, height: 60)
        let PhoneTextFieldFrame = CGRect(x: 20, y: 280, width: width, height: 60)
        
        nameField = SkyFloatingLabelTextFieldWithIcon(frame: NameTextFieldFrame)
        nameField.placeholder = "Name"
        nameField.title = "Name"
        nameField.keyboardType = .default
        nameField.autocapitalizationType = .none
        nameField.autocorrectionType = .no
        self.view.addSubview(nameField)
        
        addressField = SkyFloatingLabelTextFieldWithIcon(frame: AddressTextFieldFrame)
        addressField.placeholder = "ETH address"
        addressField.title = "ETH address"
        addressField.keyboardType = .default
        addressField.autocapitalizationType = .none
        addressField.autocorrectionType = .no
        addressField.adjustsFontSizeToFitWidth = true
        self.view.addSubview(addressField)
        
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