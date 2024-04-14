//
//  String+Extension.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    public func removeFirstAndFormatted() -> String {
        let cleanedCurrencyIcon = self.replacingOccurrences(of: "$", with: "")
        let cleaned = cleanedCurrencyIcon.replacingOccurrences(of: ",", with: "")
        
        let num = abs(Double(cleaned) ?? 0)
        let sign = (num < 0) ? "-" : ""
        
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
            return num.asNumberString()
            
        default:
            return "\(sign)\(self)"
        }
    }
    
    public func removeFirst(value: String) -> String {
        self.replacingOccurrences(of: value, with: "")
    }
    
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
