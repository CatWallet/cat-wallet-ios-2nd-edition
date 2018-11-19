//
//  SuccessCreationViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/14/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SuccessCreationViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    let setButton = SetButton()
    var getAddress = ""
    var getMnemonics = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton.setButton(doneButton, 2)
        textLabel.text = getAddress
        textView.text = getMnemonics
    }

    @IBAction func doneAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
