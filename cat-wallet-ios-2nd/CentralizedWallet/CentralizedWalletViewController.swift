//
//  CentralizedWalletViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/8/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import WebKit

class CentralizedWalletViewController: UIViewController {

    var web: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        setWebView()
    }
    func setWebView() {
        let scrrenSize = UIScreen.main.bounds
        let screentWidth = scrrenSize.width
        let screenHeight = scrrenSize.height
        web.frame = CGRect(x: 0, y: 0, width: screentWidth, height: screenHeight - 140)
        self.view.addSubview(web)
        let url = URL(string: "http://mp.miaoliao.im/cat_wallet/index.html")
        let task = URLSession.shared.dataTask(with: url!) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            } else {
                print("something wrong")
            }
        }
        task.resume()
        let request = URLRequest(url: url!)
        print(request)
        web.load(request)
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
}
