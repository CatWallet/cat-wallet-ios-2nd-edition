//
//  SendTableViewCell.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 11/9/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import UIKit

class SendTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var coinNum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
