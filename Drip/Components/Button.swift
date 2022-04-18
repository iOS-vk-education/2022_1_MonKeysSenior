//
//  Button.swift
//  Drip
//
//  Created by mikh.popov on 10.04.2022.
//

import UIKit

class Button: UIButton {
    open func setupDefault(title: String, titleColor: UIColor, backgroundColor: UIColor) -> Void {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        self.backgroundColor = backgroundColor
    }
}
