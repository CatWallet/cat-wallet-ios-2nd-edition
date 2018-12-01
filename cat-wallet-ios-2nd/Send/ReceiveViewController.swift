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
//import EthereumAddress

class ReceiveViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressimage: UIImageView!
    var cKeyStore = CurrentKeyStoreRealm()
    override func viewDidLoad() {
        super.viewDidLoad()
        getKeyStore()
        generate()
    
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
    
    func getKeyStore() {
        cKeyStore = fetchCurrenKeyStore()
    }
}
