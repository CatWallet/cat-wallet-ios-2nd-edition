//
//  TokensServiceHandler.swift
//  cat-wallet-ios-2nd
//
//  Created by kaidong pei on 1/28/19.
//  Copyright © 2019 CatWallet. All rights reserved.
//

import Foundation

final class TokensServiceHandler: NSObject {
    static var sharedInstance = TokensServiceHandler()
    private override init() {}
    
    func getTokens(completion: @escaping completionHandler) {
        var getToken = [TokensStructure]()
        guard let url = URL(string: tokensAPI) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }
                guard let data = data else { return }
                print(data)
                do {
                    let decoder = JSONDecoder()
                    let getData = try decoder.decode(TokensStructure.self, from: data)
                    getToken = [getData]
                    completion(getToken)
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
            }
        }.resume()
    }
}
