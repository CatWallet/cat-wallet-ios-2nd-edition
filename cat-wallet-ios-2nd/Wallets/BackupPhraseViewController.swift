//
//  BackupPhraseViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/18/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class BackupPhraseViewController: UIViewController {

    @IBOutlet weak var phraseTextView: UITextView!
    var getText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseTextView.text = getText
        // Do any additional setup after loading the view.
    }
}
