//
//  SendViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/8/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit


class WalletsViewController: UIViewController {
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UITapGestureRecognizer(target: self.view, action: "Selector(“endEditing:”)")
//        tap.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tap)
        title = "Wallet"
        setupSGPagingView()
    }
    override func viewWillAppear(_ animated: Bool) {
        //navigationController!.navigationBar.barTintColor = UIColor.
    }
    
    @IBAction func button(_ sender: Any) {
        
    }
    
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let titles = ["WA", "WB", "DApp"]
        let configure = SGPageTitleViewConfigure()
        configure.titleColor = UIColor.lightGray
        configure.titleSelectedColor = UIColor.black
        configure.indicatorColor = UIColor.black
        configure.indicatorAdditionalWidth = 80
        configure.titleGradientEffect = true
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        //pageTitleView?.backgroundColor = UIColor.black
        view.addSubview(pageTitleView!)
        
        let vc = SendNavigationTableViewController()
        let vc1 = CentralizedWalletViewController()
        let vc2 = DAppViewController()
        let childVCs = [vc,vc1,vc2]
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
    }
}

extension WalletsViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
