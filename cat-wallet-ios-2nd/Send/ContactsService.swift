//
//  ContactsService.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/25/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import RealmSwift


struct ContactsService {
    let realm = try! Realm()
    let contact = Contact()
    
    func saveContact(_ name: String, _ address: String, _ BTCAddress: String, _ email: String, _ phone: Int) {
        contact.name = name
        contact.address = address
        contact.BTCAddress = BTCAddress
        contact.email = email
        contact.phone = phone
        try! realm.write{
            realm.add(contact)
        }
    }
    
    func updateContact(_ name: String, _ address: String, _ BTCAddress: String, _ email: String, _ phone: Int, _ ID: String) {
        contact.id = ID
        contact.name = name
        contact.address = address
        contact.BTCAddress = BTCAddress
        contact.email = email
        contact.phone = phone
        try! realm.write{
            realm.add(contact, update: true)
        }
    }
    
    func fetchContacts() -> [Contact]{
        var contacts: [Contact] = []
        let contactsRealm = realm.objects(Contact.self)
        for i in contactsRealm {
            contacts.append(i)
        }
        return contacts
    }
    
    func fetchBTCContacts() -> [Contact]{
        var contacts: [Contact] = []
        let contactsRealm = realm.objects(Contact.self).filter("BTCAddress != ''")
        for i in contactsRealm {
            contacts.append(i)
        }
        return contacts
    }
    
    func deletAllContacts() {
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func deleteWallet(_ name: String) {
        let realm = try! Realm()
        let contact = realm.objects(Contact.self).filter("name == '\(name)'")
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func searchOnlineContact() {
        
    }
}
