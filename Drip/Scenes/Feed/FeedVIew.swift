//
//  FeedVIew.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import UIKit
import PinLayout
import Kingfisher


protocol FeedViewDelegate: AnyObject {
    func likedCurrent()
    func dislikedCurrent()
}

protocol FeedViewDataSource: AnyObject {
    func currentCard() -> Profile
}

final class FeedView: UIView {
    
    weak var delegate: FeedViewDelegate?
    
    private let bottomPanelView: UIView = {
        let container = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 350, height: 135)
        container.layer.cornerRadius = 12
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = container.frame
        blurEffectView.layer.cornerRadius = 12 
        blurEffectView.clipsToBounds = true
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(blurEffectView)
        
        
        
//       container.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        return container
    }()
    private let cardContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .red
        return container
    }()
    
    private let cardImage: UIImageView = {
        let url = URL(string: "https://cdnimg.rg.ru/img/content/222/64/81/8961287_d_850.jpg")
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.kf.setImage(with: url)
        image.frame = CGRect(x:0, y:0, width: 350, height: 575)
        image.layer.cornerRadius = 12;
        image.clipsToBounds = true
        
        
        return image
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "21"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return label
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
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "likes")
        let iconOriginalColors = icon?.withRenderingMode(.alwaysOriginal)
        button.setImage(iconOriginalColors, for: .normal)
        button.frame = CGRect(x: 0, y:0 ,width: 40, height: 40)
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "dislike")
        let iconOriginalColors = icon?.withRenderingMode(.alwaysOriginal)
        button.setImage(iconOriginalColors, for: .normal)
        button.frame = CGRect(x: 0, y:0 ,width: 40, height: 40)
        return button
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
        
        addSubview(cardContainerView)
        
        likeButton.addTarget(self, action: #selector(likedCurrent), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikedCurrent), for: .touchUpInside)
//        expandButton
        
        cardContainerView.addSubview(cardImage)
        cardContainerView.addSubview(bottomPanelView)
        bottomPanelView.addSubview(likeButton)
        bottomPanelView.addSubview(dislikeButton)
        bottomPanelView.addSubview(expandButton)
        bottomPanelView.addSubview(nameLabel)
        bottomPanelView.addSubview(ageLabel)
        
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
