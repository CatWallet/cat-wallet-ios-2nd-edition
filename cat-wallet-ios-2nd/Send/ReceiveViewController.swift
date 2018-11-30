//
//  ReceiveViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/27/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import BigInt
import web3swift
//import EthereumAddress

class ReceiveViewController: BottomPopupViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressimage: UIImageView!
    var cKeyStore = CurrentKeyStoreRealm()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
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
    
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "=")
        navBar.setItems([navItem], animated: false)
    }
    
    override func getPopupHeight() -> CGFloat {
        let stHeight = UIApplication.shared.statusBarFrame.size.height
        let scHeight = UIScreen.main.bounds.size.height
        let height = Int(scHeight) - Int(stHeight)
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
