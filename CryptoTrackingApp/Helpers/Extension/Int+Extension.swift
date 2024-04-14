//
//  Int+Extension.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation

extension  Int {
    func asNumberString() -> String {
       return String(format: "%.2f", self)
     }

    /// Convert a Double to a String with K, M, B, T abbreviations.
    /// ```
    /// Convert 12345678 to 12.34 M
    /// Convert 123456789012 to 123.45 B
    /// Convert 12345678901234 to 12.34 T

    func formattedWithAbbreviations() -> String {
      let num = abs(Double(self))
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
}
