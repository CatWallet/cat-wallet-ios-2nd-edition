//
//  SignUpViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Parse
import PhoneNumberKit
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController{
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var addressField = SkyFloatingLabelTextField()
    var userNameField = SkyFloatingLabelTextField()
    let phoneNumberKit = PhoneNumberKit()
    let shownoti = ShowNotiBar()
    var sendButton = UIButton()
    var skipButton = UIButton()
    var emailVerification = true
    var savedPhoneOrEmail = ""
    var sentCode = false
    var cloudCodePending = false
    var buttonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setFloatTextField()
        setFloatButton()
        setSkipButton()
        initializView()
    }
    
    func setFloatButton() {
        sendButton = UIButton(type: .custom)
        sendButton.backgroundColor = .black
        sendButton.setTitle("SignUp", for: .normal)
        sendButton.tintColor = .white
        self.view.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonConstraint = sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        buttonConstraint.isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.layoutIfNeeded()
        subscribeToShowKeyboardNotifications()
        sendButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sendButton.layer.masksToBounds = false
        sendButton.layer.cornerRadius = sendButton.frame.width / CGFloat(28)
        sendButton.layer.borderWidth = 3.5
    }
    
    func setSkipButton() {
        let x = UIScreen.main.bounds.size.width
        skipButton = UIButton(frame: CGRect(x: x - 60, y: 300, width: 30, height: 30))
        skipButton.setImage(UIImage(named: "skip"), for: .normal)
        skipButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        self.view.addSubview(skipButton)
    }
    
    func initializView() {
        sentCode = false
        sendButton.isEnabled = true
        cloudCodePending = false
        segmentControl.isHidden = false
        segmentAction(segmentControl)
        sendButton.setTitle("Send verification code", for: .normal)
    }
    
    func sentVCode() {
        sentCode = true
        sendButton.isEnabled = true
        cloudCodePending = false
        segmentControl.isHidden = true
        addressField.text = ""
        addressField.placeholder = "Enter verification code"
        addressField.title = "Enter verification code"
        addressField.keyboardType = .default
    }
    
    @objc func buttonAction() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        let input = addressField.text!.lowercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if input.isEmpty {
            shownoti.showBar(title: "Please enter email or phone!", subtitle: "", style: .warning)
            return
        }
        
        if cloudCodePending { return }
        cloudCodePending = true
        sendButton.isEnabled = false
        
        if !sentCode {
            var params = ["email": input]
            savedPhoneOrEmail = input
            if !emailVerification {
                do {
                    let num = try phoneNumberKit.parse( input )
                    savedPhoneOrEmail = phoneNumberKit.format(num, toType: .e164)
                    params = ["phone":  savedPhoneOrEmail]
                }
                catch {
                    self.shownoti.showBar(title: "Error!", subtitle: "", style: .danger)
                    sendButton.isEnabled = true
                    cloudCodePending = false
                    return
                }
            }
            
        
            PFCloud.callFunction(inBackground: "sendCode", withParameters: params) { [weak self] (results : Any?, error : Error?) -> Void in
                if error != nil {
                    self?.initializView()
                    self!.shownoti.showBar(title: "Error!", subtitle: "", style: .danger)
                }
                else {
                    self?.sentVCode()
                }
            }
        }
        else {
            var params = ["code" : addressField.text!]
            if emailVerification {
                params["email"]  = savedPhoneOrEmail
            }
            else {
                params["phone"]  = savedPhoneOrEmail
            }
            
            PFCloud.callFunction(inBackground: "logIn", withParameters: params) {
                [weak self] (response: Any?, error: Error?) -> Void in
                if error != nil {
                    self?.initializView()
                    self!.shownoti.showBar(title: "Error!", subtitle: "", style: .danger)
                }
                else if let token = response as? String {
                    PFUser.become(inBackground: token) { (user: PFUser?, error: Error?) -> Void in
                        if error != nil {
                            self!.shownoti.showBar(title: "Error!", subtitle: "", style: .danger)
                            self?.initializView()
                        }
                        else {
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
                else {
                    self!.shownoti.showBar(title: "Error!", subtitle: "", style: .danger)
                    self?.initializView()
                }
            }
        }
    }

        

    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        addressField.text = ""
        if segmentControl.selectedSegmentIndex == 0 {
            emailVerification = true
            addressField.placeholder = "Email"
            addressField.title = "Email"
            addressField.keyboardType = .default
        }
        else {
            emailVerification = false
            addressField.placeholder = "Phone"
            addressField.title = "Phone"
            addressField.keyboardType = .phonePad
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        buttonConstraint.constant = -25 - keyboardHeight
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonConstraint.constant = -25
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
    
    func setFloatTextField() {
        let width = UIScreen.main.bounds.size.width - 40
        let AddressTextFieldFrame = CGRect(x: 20, y: 200, width: width, height: 60)
        let amountTextFieldFrame = CGRect(x: 20, y: 200, width: width, height: 60)
        addressField = SkyFloatingLabelTextFieldWithIcon(frame: AddressTextFieldFrame)
        addressField.placeholder = "Email"
        addressField.title = "Email"
        addressField.keyboardType = .default
        addressField.autocapitalizationType = .none
        addressField.autocorrectionType = .no
        addressField.adjustsFontSizeToFitWidth = true
        self.view.addSubview(addressField)
        userNameField = SkyFloatingLabelTextFieldWithIcon(frame: amountTextFieldFrame)
        userNameField.placeholder = "Username"
        userNameField.title = "Username"
        userNameField.keyboardType = .numberPad
        //self.view.addSubview(userNameField)
    }
}

extension SignUpViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SendViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
