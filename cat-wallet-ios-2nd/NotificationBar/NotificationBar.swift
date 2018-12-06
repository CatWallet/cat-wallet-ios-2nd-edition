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
    let success = UIImageView(image: #imageLiteral(resourceName: "success"))
    let danger = UIImageView(image: #imageLiteral(resourceName: "danger"))
    
    func showBar(title: String, subtitle: String, style: BannerStyle) {
        var view = UIImageView()
        if style == BannerStyle.danger {
            view = danger
        } else {
            view = success
        }
        let banner = NotificationBanner(title: title, subtitle: subtitle, leftView: view, rightView: nil, style: style)
        banner.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            banner.dismiss()
        }
    }
    
    func hide(bar: NotificationBanner) {
        bar.dismiss()
    }
}
