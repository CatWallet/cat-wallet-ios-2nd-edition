//
//  NewWalletTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/19/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import Web3swift
import HexColors
import MBProgressHUD
import EthereumAddress
import SWSegmentedControl

class NewWalletTableViewController: UITableViewController {
    
    var height = CGFloat(300)
    var keyStore = CurrentKeyStoreRealm()
    var web3Rinkeby = Web3.InfuraRinkebyWeb3()
    let ws = WalletService()
    let shownotibar = ShowNotiBar()
    var buttonConstraint: NSLayoutConstraint!
    var segment: SWSegmentedControl!
    var textView: UITextView!
    let button = UIButton()
    var loadingNotification = MBProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        setSegmentedControl()
        textView = UITextView(frame: CGRect(x: 0, y: height/2, width: width, height: 30))
        textView.textAlignment = .center
        textView.text = "Create a wallet"
        textView.font = UIFont(name: "Avenir-Light", size: 18)
        textView.textColor = UIColor("#0E59B4")
        self.navigationItem.rightBarButtonItem = nil
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        button.frame = CGRect(x: width/2 - 20, y: height/2.3, width: 40, height: 40)
        self.view.addSubview(button)
        self.view.addSubview(textView)
        return 0
    }
    
    @objc func add() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            createWallet()
        case 1:
            let viewController = ImportViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    @objc func segmentAction() {
        switch segment.selectedSegmentIndex
        {
        case 0:
            textView.text = "Create a wallet"
            button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        case 1:
            textView.text = "Import a wallet"
            button.setBackgroundImage(UIImage(named: "wallet_import"), for: .normal)
        default:
            break
        }
    }
    
    private func createWallet() {
        self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
        let ws = WalletService()
        ws.createHDWallet(withName: "String", password: "Password") { (keyWallet, error, mnemonics, btcAddress) in
            if error != nil {
                print(error as! String)
            } else {
                let vc = NewWalletResultViewController()
                vc.getAddress = keyWallet?.address ?? ""
                vc.getMnemonics = mnemonics ?? ""
                vc.getBtcAddress = btcAddress ?? ""
                self.loadingNotification.hide(animated: false)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func setSegmentedControl() {
        segment = SWSegmentedControl(items: ["New", "Import"])
        segment.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        segment.sizeToFit()
        segment.tintColor = UIColor.white
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
