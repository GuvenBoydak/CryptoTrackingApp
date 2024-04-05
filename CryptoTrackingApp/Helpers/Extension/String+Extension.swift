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
}
