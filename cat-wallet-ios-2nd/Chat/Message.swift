//
//  Message.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 12/10/18.
//  Copyright © 2018 CatWallet. All rights reserved.
//

import Foundation
import Parse

class Message: PFObject{
    
    @NSManaged var sender_id: String
    @NSManaged var display_name: String
    @NSManaged var body_text: String
    @NSManaged var conversation_id: String
}

extension Message: PFSubclassing {
    static func parseClassName() -> String {
        return "Message"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: Message.parseClassName())
        query.cachePolicy = .networkOnly
        return query
    }
}
