//
//  CatDappViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/15/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit
import WebKit
import HexColors

class CatDappViewController: UIViewController {

    var web: WKWebView = WKWebView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setWebView()
    }
    
    func setWebView() {
        title = "DApp"
        let scrrenSize = UIScreen.main.bounds
        let screentWidth = scrrenSize.width
        let screenHeight = scrrenSize.height
        let tabbarHeight = (self.tabBarController?.tabBar.frame.height)! + 50
        web.frame = CGRect(x: 0, y: 0, width: screentWidth, height: screenHeight - tabbarHeight)
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
    
    @IBAction func homeButtonAction(_ sender: Any) {
        if let url = URL(string: "https://www.stateofthedapps.com/") {
            let request = URLRequest(url: url)
            web.load(request)
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        if self.web.canGoBack {
            print("Can go back")
            self.web.goBack()
            self.web.reload()
        } else {
            
        }
    }
    @IBAction func forwardButtonAction(_ sender: Any) {
        if self.web.canGoForward {
            self.web.goForward()
            self.web.reload()
        } else {
            
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        get {
            return false
        }
    }
}
