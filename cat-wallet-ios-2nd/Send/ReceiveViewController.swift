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
import EthereumAddress

class ReceiveViewController: BottomPopupViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressimage: UIImageView!
    var cKeyStore = CurrentKeyStoreRealm()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getKeyStore()
        setImage()
    
    }
    
    func setImage() {
        var eip67Data = Web3.EIP67Code.init(address: EthereumAddress(cKeyStore.address)!)
        eip67Data.gasLimit = BigUInt(21000)
        eip67Data.amount = BigUInt("1000000000000000000")
        let encoding = eip67Data.toImage(scale: 10.0)
        self.addressimage.image = UIImage(ciImage: encoding)
        self.addressimage.contentMode = .scaleAspectFit
        addressLabel.text = cKeyStore.address
        addressLabel.adjustsFontSizeToFitWidth = true
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
        let height = Int(scHeight) - Int(stHeight*2)
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
