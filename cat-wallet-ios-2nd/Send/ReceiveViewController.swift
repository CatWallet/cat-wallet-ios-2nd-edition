//
//  ReceiveViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/27/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import BigInt
import Web3swift


class ReceiveViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressimage: UIImageView!
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var copyButton: UIButton!
    var buttonConstraint: NSLayoutConstraint!
    var cKeyStore = CurrentKeyStoreRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
        getWallet()
        generate()
        setCopyButton()
    }
    
    func generate(){
        let context = CIContext()
        let data = cKeyStore.address.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            if let output = filter.outputImage?.transformed(by: transform), let cgImage = context.createCGImage(output, from: output.extent) {
                addressLabel.text = cKeyStore.address
                addressLabel.adjustsFontSizeToFitWidth = true
                addressimage.image = UIImage(cgImage: cgImage)
            }
        }
    }
    
    func setCopyButton() {
        copyButton = UIButton(type: .custom)
        copyButton.backgroundColor = .black
        copyButton.setTitle("Copy", for: .normal)
        copyButton.tintColor = .white
        self.view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        copyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        copyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        buttonConstraint = copyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(25 +  UIApplication.shared.statusBarFrame.size.height))
        buttonConstraint.isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.layoutIfNeeded()
        copyButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        copyButton.layer.masksToBounds = false
        copyButton.layer.cornerRadius = copyButton.frame.width / CGFloat(28)
        copyButton.layer.borderWidth = 3.5
    }
    
    @objc func copyAction() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = addressLabel.text
        if pasteboard.string != nil {
            shownotibar.showBar(title: "Public key is copied", subtitle: "", style: .success)
        }
    }
    
    func getWallet() {
        cKeyStore = ws.fetchCurrenKeyStore()
    }
}
