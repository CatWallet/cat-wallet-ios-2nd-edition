//
//  TokensTableViewCell.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import UIKit

class TokensTableViewCell: UITableViewCell {

    @IBOutlet weak var tokenName: UILabel!
    @IBOutlet weak var tokenSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
