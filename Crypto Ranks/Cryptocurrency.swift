//
//  Cryptocurrency.swift
//  Crypto Ranks
//
//  Created by Xavier Jones on 6/25/21.
//

import Foundation

struct Cryptocurrency: CustomStringConvertible, Comparable{
    var name: String
    var symbol: String
    var price: Double
    var rank: Int
    var change: Double
    //Conforms to CustomStringConvertible
    var description: String{
        return "\(name) has had a percent change of \(change) in the last 7 days and is currently sitting at $\(price) per share. It’s rank among cryptocurrencies is \(rank)."
    }
    //Conforms to Comparable
    static func < (lhs: Cryptocurrency, rhs: Cryptocurrency) -> Bool {
        return lhs.rank < rhs.rank
    }

}
