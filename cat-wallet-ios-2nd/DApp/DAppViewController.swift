//
//  DAppViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/12/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit
import WebKit

class DAppViewController: UIViewController {
    
    var web: WKWebView = WKWebView()

    override func viewWillAppear(_ animated: Bool) {
        setWebView()
    }
//    override func viewDidLoad() {
//        setWebView()
//    }
    
    func setWebView() {
        let scrrenSize = UIScreen.main.bounds
        let screentWidth = scrrenSize.width
        let screenHeight = scrrenSize.height
        web.frame = CGRect(x: 0, y: 0, width: screentWidth, height: screenHeight)
        self.view.addSubview(web)
        let url = URL(string: "https://www.stateofthedapps.com/")
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
            return false
        }
    }
}
