//
//  CryptoDetailsViewController.swift
//  Crypto Ranks
//
//  Created by Xavier Jones on 6/26/21.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    var selectedCrypto: Cryptocurrency?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedCrypto!.name
        symbolLabel.text = selectedCrypto!.symbol
        descLabel.text = selectedCrypto!.description
        priceLabel.text = "$\(selectedCrypto!.price)"
        rankLabel.text = "# \(String(selectedCrypto!.rank))"
        changeLabel.text = "\(selectedCrypto!.change)%"
        // Do any additional setup after loading the view.
    }

}
