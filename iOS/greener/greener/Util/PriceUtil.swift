//
//  PriceUtil.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import Foundation

class PriceUtil {
    static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-IN")
        formatter.currencySymbol = "₹"
        formatter.numberStyle = .currency
        
        return formatter
    }()
    

    static func getFormattedPrice(price: Int) -> String {
        return PriceUtil.numberFormatter.string(from: NSNumber(integerLiteral: price)) ?? "₹ \(price)"
    }
}
