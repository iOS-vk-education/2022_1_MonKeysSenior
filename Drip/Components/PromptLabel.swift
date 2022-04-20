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

