//
//  BackupPhraseViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/18/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import HexColors

class BackupPhraseViewController: UIViewController {

    @IBOutlet weak var phraseTextView: UITextView!
    var getText = ""
    var copyButton: UIButton!
    var buttonConstraint: NSLayoutConstraint!
    let shownotibar = ShowNotiBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseTextView.text = getText
        setCopyButton()
        // Do any additional setup after loading the view.
    }
    
    func setCopyButton() {
        copyButton = UIButton(type: .custom)
        copyButton.backgroundColor = UIColor("#0E59B4")
        copyButton.setTitle("Copy", for: .normal)
        copyButton.tintColor = .white
        self.view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        copyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        copyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonConstraint = copyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        buttonConstraint.isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.layoutIfNeeded()
        copyButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        copyButton.layer.masksToBounds = false
        copyButton.layer.cornerRadius = copyButton.frame.width / CGFloat(28)
    }
    
    @objc func copyAction() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = phraseTextView.text
        if pasteboard.string != nil {
            shownotibar.showBar(title: "Public key is copied", subtitle: "", style: .success)
        }
    }
}
