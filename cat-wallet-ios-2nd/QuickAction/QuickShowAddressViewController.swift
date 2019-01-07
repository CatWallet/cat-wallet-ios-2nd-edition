//
//  QuickShowAddressViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/5/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit

class QuickShowAddressViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var QRimage: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    let ws = WalletService()
    var cKeyStore = CurrentKeyStoreRealm()
    var ETH = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getWallet()
        generate()
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        if ETH {
            ETH = false
        } else {
            ETH = true
        }
        generate()
    }
    
    func getWallet() {
        cKeyStore = ws.fetchCurrenKeyStore()
    }
    
    func generate(){
        let context = CIContext()
        var address = ""
        var label = ""
        if ETH {
            address = cKeyStore.address
            label = "ETH"
        } else {
            address = cKeyStore.btcaddress
            label = "BTC"
        }
        let data = address.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            if let output = filter.outputImage?.transformed(by: transform), let cgImage = context.createCGImage(output, from: output.extent) {
                nameLabel.text = label
                nameLabel.adjustsFontSizeToFitWidth = true
                QRimage.image = UIImage(cgImage: cgImage)
            }
        }
    }
}
