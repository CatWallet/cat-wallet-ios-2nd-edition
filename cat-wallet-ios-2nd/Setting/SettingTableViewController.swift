//
//  SettingTableViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/21/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import Eureka
import LocalAuthentication

class SettingTableViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Setting"
    }
    
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    func setTableView() {
        form +++ Section()
            <<< SwitchRow("FaceID") {
                $0.title = "FaceID/Passcode"
                $0.value = false
                }.onChange { [] in
                    if $0.value ?? false {
                        //self.setFaceID()
                    }
                    else {
                        //self.setFaceID()
            }
        }
    
            
        form +++ Section()
        <<< PushRow<currency>("Curreny"){
            $0.title = $0.tag
            $0.options = currency.allValues
            $0.value = .usd
            }.onPresent({ (_, vc) in
                vc.enableDeselection = false
                vc.dismissOnSelection = false
            })

        
        form +++ Section()
            <<< ButtonRow(){
                $0.title = "Twitter"
                }.onCellSelection({ (_, _) in
//                    if let localURL = type.localURL, UIApplication.shared.canOpenURL(localURL) {
//                        UIApplication.shared.open(localURL, options: [:], completionHandler: .none)
//                    } else {
//                        UIApplication.shared.open(type.remoteURL, options: [:], completionHandler: .none)
//                    }
                }).cellUpdate { cell, _ in
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = .black
            }
            <<< ButtonRow(){
                $0.title = "Telegram Group"
                }.onCellSelection({ (_, _) in
//                    if let localURL = type.localURL, UIApplication.shared.canOpenURL(localURL) {
//                        UIApplication.shared.open(localURL, options: [:], completionHandler: .none)
//                    } else {
//                        UIApplication.shared.open(type.remoteURL, options: [:], completionHandler: .none)
//                    }
                }).cellUpdate { cell, _ in
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = .black
            }
            <<< ButtonRow(){
                $0.title = "Facebook"
                }.onCellSelection({ (_, _) in
//                    if let localURL = type.localURL, UIApplication.shared.canOpenURL(localURL) {
//                        UIApplication.shared.open(localURL, options: [:], completionHandler: .none)
//                    } else {
//                        UIApplication.shared.open(type.remoteURL, options: [:], completionHandler: .none)
//                    }
                }).cellUpdate { cell, _ in
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = .black
            }
            <<< ButtonRow(){
                $0.title = "Discord"
                }.onCellSelection({ (_, _) in
//                    if let localURL = type.localURL, UIApplication.shared.canOpenURL(localURL) {
//                        UIApplication.shared.open(localURL, options: [:], completionHandler: .none)
//                    } else {
//                        UIApplication.shared.open(type.remoteURL, options: [:], completionHandler: .none)
//                    }
                }).cellUpdate { cell, _ in
                    cell.accessoryType = .disclosureIndicator
                    cell.textLabel?.textAlignment = .left
                    cell.textLabel?.textColor = .black
        }
    }

    func setFaceID() -> BiometricType{
            let context = LAContext()
            var error: NSError?

            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                print(error?.localizedDescription ?? "")
                return .none
            }

            if #available(iOS 11.0, *) {
                switch context.biometryType {
                case .none:
                    return .none
                case .touchID:
                    return .touchID
                case .faceID:
                    return .faceID
                }
            } else {
                return  .touchID
            }
    }
    
    enum currency : String, CustomStringConvertible {
        case usd = "US Dollar"
        case eur = "Euro"
        case cny = "Chinese Yuan"
        
        var description : String { return rawValue }
        
        static let allValues = [usd, eur, cny]
    }
}
