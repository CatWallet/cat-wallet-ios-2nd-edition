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
        title = "Setting"
    }
    
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    func setTableView() {
        form +++
            Section()
            <<< SwitchRow("FaceID") {
                $0.title = "FaceID/Passcode"
                $0.value = false
                }.onChange { [] in
                    if $0.value ?? false {
                        //self.setFaceID()
                    }
                    else {
                        self.setFaceID()
            }
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
}
