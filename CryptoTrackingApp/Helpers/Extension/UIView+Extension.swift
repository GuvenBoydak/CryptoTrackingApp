//
//  UIView+Extension.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
