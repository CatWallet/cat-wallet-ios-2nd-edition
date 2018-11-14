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
        
        let titles = ["Wallet A", "Wallet B","DApp"]
        let configure = SGPageTitleViewConfigure()
        configure.showIndicator = false
        configure.titleTextZoom = true
        configure.titleTextZoomRatio = 0.5
        configure.titleAdditionalWidth = 30
        configure.titleGradientEffect = true
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 44), delegate: self, titleNames: titles, configure: configure)
        pageTitleView?.backgroundColor = UIColor.lightGray
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
