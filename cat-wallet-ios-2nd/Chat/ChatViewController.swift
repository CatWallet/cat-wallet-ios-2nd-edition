//
//  ChatViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Parse
import GrowingTextView

class ChatViewController: UIViewController, GrowingTextViewDelegate {
    
    var conversationId: String!
    var inputToolbar: UIView!
    var textView: GrowingTextView!
    var textViewBottomConstraint: NSLayoutConstraint!
    var shownoti = ShowNotiBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //checkRegistration()
        let user = PFUser.current()
        
        print(user?.username)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        checkRegistration()
        setTextView()
        
        let user = PFUser.current()
        
        print(user?.username)
    }
    
    func setTextView() {
        inputToolbar = UIView()
        inputToolbar.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        inputToolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputToolbar)
        
        textView = GrowingTextView()
        textView.delegate = self
        textView.layer.cornerRadius = 4.0
        textView.maxLength = 200
        textView.maxHeight = 70
        textView.trimWhiteSpaceWhenEndEditing = true
        textView.placeholder = "Say something..."
        textView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardType = .default
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.returnKeyType = .send
        inputToolbar.addSubview(textView)
        
        let topConstraint = textView.topAnchor.constraint(equalTo: inputToolbar.topAnchor, constant: 8)
        topConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            inputToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topConstraint
            ])
        
        if #available(iOS 11, *) {
            textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: inputToolbar.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: inputToolbar.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: inputToolbar.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                textViewBottomConstraint
                ])
        } else {
            textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: inputToolbar.bottomAnchor, constant: -8)
            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: inputToolbar.leadingAnchor, constant: 8),
                textView.trailingAnchor.constraint(equalTo: inputToolbar.trailingAnchor, constant: -8),
                textViewBottomConstraint
                ])
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if #available(iOS 11, *) {
                if keyboardHeight > 0 {
                    keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                }
            }
            textViewBottomConstraint.constant = -keyboardHeight - 8
            view.layoutIfNeeded()
        }
    }
    
    @objc private func tapGestureHandler() {
        view.endEditing(true)
    }

    @IBAction func updateUsername(_ sender: Any) {
        if let user = PFUser.current() {
            let alert = UIAlertController(title: "Update username", message: "!You can only change your username once!", preferredStyle: .alert)
            alert.addTextField { (usernametextfield: UITextField) in
                usernametextfield.placeholder = "Username"
            }
            let confirmaction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                let username = alert.textFields![0]
                if username.text != ""{
                    user["username"] = username.text
                    user.saveInBackground()
                    self.shownoti.showBar(title: "Your username has been changed successfully.", subtitle: "", style: .success)
                } else {
                    self.shownoti.showBar(title: "Please enter a username.", subtitle: "", style: .warning)
                }
            }
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(confirmaction)
            alert.addAction(cancelaction)
            self.present(alert, animated: true) {
                //update tb view
            }
        }
    }
    func checkRegistration() {
        if PFUser.current() == nil {
            let vc = SignUpViewController()
            self.present(vc, animated: true, completion: nil)
        } else {
            
        }
    }
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            view.endEditing(true)
            print(textView.text)
            textView.text = ""
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
