//
//  ContactsViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class ContactsViewController: BottomPopupViewController, UITableViewDataSource, UITableViewDelegate, BottomPopupDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var name = ["Lucy"]
    var height = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "contactCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Contacts")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(addContact))
        let dismiss = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(dismissAction))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = dismiss
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func addContact() {
        let alertController = UIAlertController(title: "Add contact", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter contact Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let contactName = alertController.textFields![0]
            if let getName = contactName.text{
                self.name.append(getName)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as? ContactsTableViewCell
        cell?.textLabel?.text = name[indexPath.row]
        return cell!
    
    }
    
    override func getPopupHeight() -> CGFloat {
        let stHeight = UIApplication.shared.statusBarFrame.size.height
        let scHeight = UIScreen.main.bounds.size.height
        height = Int(scHeight) - Int(stHeight*2)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
