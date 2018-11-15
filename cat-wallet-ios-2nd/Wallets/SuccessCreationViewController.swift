//
//  SuccessCreationViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/14/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SuccessCreationViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var getAddress = ""
    var getMnemonics = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = getAddress
        textView.text = getMnemonics
        // Do any additional setup after loading the view.
    }

    @IBAction func doneAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
