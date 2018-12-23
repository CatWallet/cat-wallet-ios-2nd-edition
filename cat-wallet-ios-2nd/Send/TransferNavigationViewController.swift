//
//  TransferNavigationViewController.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/30/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit


class TransferNavigationViewController: BottomPopupViewController {

    @IBOutlet weak var dismissButon: UIButton!
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil
    var cryptoname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSGPagingView()
        setDimissButton()
    }
    
    func setDimissButton() {
        let yPosition = UIScreen.main.bounds.width
        let button = UIButton(frame: CGRect(x: 0, y: yPosition/2, width: 30, height: 30))
        button.setTitle("X", for: .normal)
        self.view.addSubview(button)
    }

    
    private func setupSGPagingView() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0.0
        if statusHeight == 20 {
            pageTitleViewY = 24
        } else {
            pageTitleViewY = 38
        }
        
        let titles = ["Send", "Receive", "History"]
        let configure = SGPageTitleViewConfigure()
        configure.titleColor = UIColor.lightGray
        configure.titleSelectedColor = UIColor.black
        configure.indicatorColor = UIColor.black
        configure.indicatorAdditionalWidth = 80
        configure.titleGradientEffect = true
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: pageTitleViewY, width: view.frame.size.width, height: 38), delegate: self, titleNames: titles, configure: configure)
        view.addSubview(pageTitleView!)
        
        
        guard let send = UIStoryboard(name: "SendStoryboard", bundle: nil).instantiateViewController(withIdentifier: "customNavController") as? SendNavigationViewController else { return }
        let receive = ReceiveViewController()
        let history = HistoryViewController()
        let childVCs = [send, receive, history]
        let contentViewHeight = view.frame.size.height - self.pageTitleView!.frame.maxY
        let contentRect = CGRect(x: 0, y: (pageTitleView?.frame.maxY)!, width: view.frame.size.width, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
    }
    
    override func getPopupHeight() -> CGFloat {
        let stHeight = UIApplication.shared.statusBarFrame.size.height
        let scHeight = UIScreen.main.bounds.size.height
        let height = Int(scHeight) - Int(stHeight)
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

extension TransferNavigationViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
