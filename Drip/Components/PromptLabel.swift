//
//  PromptLabel.swift
//  Drip
//
//  Created by mikh.popov on 10.04.2022.
//

import UIKit

class PromptLabel: UILabel {
    open func setup(text: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
        self.font = UIFont.boldSystemFont(ofSize: 8)
        self.text = text
    }
    
    open func isError() {
        self.textColor = .red
        self.isHidden = false
    }
    
    open func isPrompt() {
        self.textColor = .lightGray
        self.isHidden = false
    }
}

