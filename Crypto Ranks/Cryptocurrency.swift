//
//  Cryptocurrency.swift
//  Crypto Ranks
//
//  Created by Xavier Jones on 6/25/21.
//

import Foundation
import UIKit

struct Cryptocurrency: CustomStringConvertible, Comparable, Codable{
    var id: String
    var name: String
    var symbol: String
    var price: String
    var rank: Int
    var change: String
    var color: CGColor{
        if (Double(change)! > 0){
            return CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }else{
            return CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    //Conforms to CustomStringConvertible
    var description: String{
        return "\(name) has had a percent change of \(change)% in the last 7 days and is currently sitting at $\(price) per share. Its rank among cryptocurrencies is #\(rank)."
    }
    //Conforms to Comparable
    static func < (lhs: Cryptocurrency, rhs: Cryptocurrency) -> Bool {
        return lhs.rank < rhs.rank
    }
    //Matches Key-Value pairs
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case symbol
        case price = "price_usd"
        case rank
        case change = "percent_change_7d"
    }
    
    
}
struct CurrenciesResults: Codable{
    var data: [Cryptocurrency]
}
