//
//  SendPopUpViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SendPopUpViewController: BottomPopupViewController , BottomPopupDelegate{
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setButton(sendButton, 18)
        setButton(receiveButton, 2)
        setButton(historyButton, 2)
        setButton(purchaseButton, 2)

        // Do any additional setup after loading the view.
    }
    @IBAction func historyButtonAction(_ sender: Any) {
        let popupVC = HistoryViewController()
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    private func setButton(_ button: UIButton, _ num: Int) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = button.frame.width / CGFloat(num)
        button.layer.borderWidth = 1
    }
    
    override func getPopupHeight() -> CGFloat {
        return CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return CGFloat(35)
    }
    
    override func getPopupPresentDuration() -> Double {
        return 0.3
    }
    
    override func getPopupDismissDuration() -> Double {
        return 0.4
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
}
