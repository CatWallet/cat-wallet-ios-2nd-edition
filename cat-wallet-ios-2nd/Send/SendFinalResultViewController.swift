//
//  SendFinalResultViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/17/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SendFinalResultViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    let setButton = SetButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setButton.setButton(doneButton, 2)
       
    }

    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
