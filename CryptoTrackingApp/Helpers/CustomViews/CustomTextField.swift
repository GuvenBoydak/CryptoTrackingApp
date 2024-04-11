//
//  CustomTextField.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 11.04.2024.
//

import UIKit

class CustomTextField: UITextField {        
        var padding: CGFloat
        
        init(padding: CGFloat) {
            self.padding = padding
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: padding, dy: 0)
        }
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: padding, dy: 0)
        }
    }

