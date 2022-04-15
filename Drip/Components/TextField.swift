//
//  TextField.swift
//  Drip
//
//  Created by mikh.popov on 10.04.2022.
//

import UIKit

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open func setupDefault(placeholder: String, security: Bool) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.textColor = .white
        self.isSecureTextEntry = security
        self.layer.cornerRadius = 12
        self.font = UIFont.boldSystemFont(ofSize: 14)
        self.backgroundColor = UIColor(white: 0, alpha: 0.1)
    }
}
