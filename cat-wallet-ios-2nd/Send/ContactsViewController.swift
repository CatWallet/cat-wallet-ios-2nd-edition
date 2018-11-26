//
//  ContactsViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

protocol PassContactData: class {
    func passContact( _ address: String)
}

class ContactsViewController: BottomPopupViewController, UITableViewDataSource, UITableViewDelegate, BottomPopupDelegate, PassNewContact {
    
    @IBOutlet weak var tableView: UITableView!
    let contactService = ContactsService()
    var people: [Contact] = []
    var height = 0
    weak var delegate: PassContactData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setNavigationBar()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(false)
        //fetchContacts()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    func fetchContacts() {
        people = []
        people = contactService.fetchContacts()
    }
    
    func setNavigationBar() {
        let width = UIScreen.main.bounds.size.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Contacts")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(addContact))
        let dismiss = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(dismissAction))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = self.editButtonItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func addContact() {
        let popupVC = NewContactViewController()
        popupVC.delegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func passContact(_ contact: Contact) {
        people.append(contact)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell")
        cell?.textLabel?.text = people[indexPath.row].name
        cell?.detailTextLabel?.text = people[indexPath.row].address
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.contactService.deleteWallet(self.people[indexPath.row].name)
            self.people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = people[indexPath.row]
        self.dismiss(animated: true) {
            self.delegate?.passContact(index.address)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.contactService.deleteWallet(self.people[indexPath.row].name)
            self.people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
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
}
