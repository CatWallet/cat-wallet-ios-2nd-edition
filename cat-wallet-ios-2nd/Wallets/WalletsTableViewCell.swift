//
//  WalletsTableViewCell.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/26/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit

class WalletsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var walletButton: UIButton!
    
    @IBOutlet weak var walletName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
