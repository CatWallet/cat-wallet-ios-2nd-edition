//
//  NotificationBar.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/5/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import NotificationBannerSwift


struct ShowNotiBar {
    func showBar(title: String, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, leftView: nil, rightView: nil, style: style)
        banner.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            banner.dismiss()
        }
    }
    
    func hide(bar: NotificationBanner) {
        bar.dismiss()
    }
}
