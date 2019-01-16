// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import HexColors

class CoinMarketTableViewController: UITableViewController {

    var coinData = [CoinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor("#0E59B4")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        tableView.register(UINib(nibName: "CoinMarketTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        title = "Market"
        //self.title = R.string.localizable.marketTabbarItemTitle()
        getInfo()
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.title = R.string.localizable.marketTabbarItemTitle()

        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getInfo() {
        WebServiceHandler.sharedInstance.getCoin { (res) in
            if let webServiceResult = res as? [CoinData] {
                self.coinData = webServiceResult
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CoinMarketTableViewCell
        cell.nameLabel.text = coinData[indexPath.row].name
        let price = coinData[indexPath.row].quote.USD.price
        let priceChange = coinData[indexPath.row].quote.USD.percent_change_1h
        
        if priceChange > 0 {
            cell.priceChangeLabel.textColor = UIColor("#0E59B4")
            cell.priceLabel.textColor = UIColor("#0E59B4")
            cell.marketImage.image = UIImage(named: "upPointer")
        } else {
            cell.priceChangeLabel.textColor = UIColor.red
            cell.priceLabel.textColor = UIColor.red
            cell.marketImage.image = UIImage(named: "downPointer")
        }
        cell.priceChangeLabel.text = String(format: "%.3f", priceChange)
        cell.priceLabel.text = "$" + String(format: "%.4f", price)
        return cell
    }
    
    func currencyFormatter (Price: NSNumber) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: Price)!
        return String(priceString)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = CoinMarketDetialViewController(nibName: "CoinMarketDetialViewController", bundle: nil)
//            if let navigator = navigationController {
//                let price = coinData[indexPath.row].quote.USD.price
//                let priceChange = coinData[indexPath.row].quote.USD.percent_change_1h
//                vc.title = coinData[indexPath.row].name
//                vc.getPricechange = priceChange
//                vc.getPrice = "$" + String(format: "%.4f", price)
//                vc.getName = coinData[indexPath.row].name
//                navigator.pushViewController(vc, animated: true)
//        }
    }
}
