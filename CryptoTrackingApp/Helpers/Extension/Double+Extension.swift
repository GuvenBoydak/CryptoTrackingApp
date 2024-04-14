//
//  Double+Extension.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation

extension Double {
    func rounded(toDecimalPlaces places: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = places
        formatter.maximumFractionDigits = places
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        }
        return "\(self)"
    }
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0"
    }
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 0
        if self > 1 {
            formatter.maximumFractionDigits = 2
        } else {
            formatter.maximumFractionDigits = 5
        }
        
        return formatter
    }
    func formattedWithAbbreviations() -> String {
      let num = abs(self)
      let sign = (self < 0) ? "-" : ""
      
      switch num {
        case 1_000_000_000_000...:
          let formatted = num / 1_000_000_000_000
          let stringFormatted = formatted.asNumberString()
          return "$\(sign)\(stringFormatted) T"
        case 1_000_000_000...:
          let formatted = num / 1_000_000_000
          let stringFormatted = formatted.asNumberString()
          return "$\(sign)\(stringFormatted) B"
        case 1_000_000...:
          let formatted = num / 1_000_000
          let stringFormatted = formatted.asNumberString()
          return "$\(sign)\(stringFormatted) M"
        case 0...:
          return self.asNumberString()
          
        default:
          return "\(sign)\(self)"
      }
    }
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: "\(self)") {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: "\(self)") {
                return result.doubleValue
            }
        }
        return 0
    }
}
