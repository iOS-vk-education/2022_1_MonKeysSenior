//
//  ProfileView.swift
//  Drip
//
//  Created by Maksongold on 18.04.2022.
//

import UIKit
import PinLayout
import Kingfisher


final class ProfileView: UIView {
    
//    weak var delegate: FeedViewDelegate?
    
    private let cardContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .red
        return container
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Leonid"
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
            
        return label
    }()
    

    
    let expandButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "expand_big")
        let iconOriginalColors = icon?.withRenderingMode(.alwaysOriginal)
        button.setImage(iconOriginalColors, for: .normal)
        
        button.frame = CGRect(x: 0, y:0 ,width: 40, height: 40)
        return button
    }()
    
    
    weak var dataSource: FeedViewDataSource? {
        didSet {
//            button.setTitle("hello", for: .normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print(frame)
        print("hello2")
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func likedCurrent() {
        delegate?.likedCurrent()
    }
    
    @objc
    private func dislikedCurrent() {
        delegate?.dislikedCurrent()
    }
    
    override func layoutSubviews() {
        print("hello")
        super.layoutSubviews()
        layoutCardItems()
//        button.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: frame.height / 2))
    }
    private func layoutCardItems() {
        
        cardContainerView.pin.top(0).hCenter().width(100%).maxWidth(400).pinEdges()
        bottomPanelView.pin.top(440)
        nameLabel.pin.left(10).top(-10)
        ageLabel.pin.right(of: nameLabel).top(-10)
//        likeButton.pin.top().hCenter().width(100%)
        
        expandButton.pin.left(155).top(to: nameLabel.edge.bottom)
        dislikeButton.pin.left(of: expandButton).top(to: nameLabel.edge.bottom).marginRight(36)
        likeButton.pin.right(of: expandButton).top(to: nameLabel.edge.bottom).marginLeft(36)
    }
}
