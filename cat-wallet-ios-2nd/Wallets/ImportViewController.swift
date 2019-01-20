//
//  ImportViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/19/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit

class ImportViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var importTextView: UITextView!
    @IBOutlet weak var importButton: UIButton!
    let setbutton = SetButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        importTextView.delegate = self
        setUI()
        
    }

    func setUI() {
        importTextView.text = "Enter your backup phrase here to import a walle"
        importTextView.textColor = UIColor.lightGray
        setbutton.setButton(importButton, 13)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your backup phrase here to import a walle"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    @IBAction func importButtonAction(_ sender: Any) {
    }
}
