//
//  LikesCollectionViewCell.swift
//  Drip
//
//  Created by pierrelean on 20.04.2022.
//

import UIKit


final class LikesCollectionViewCell: UICollectionViewCell, CardViewDelegate {
    func likedCurrent() {
        print("liked")
    }
    
    func dislikedCurrent() {
        print("disliked")
    }
    
    func expandCurrent() {
        print("expand")
    }
    
    private let cardView: CardView = {
        let card = CardView()
//        card.frame = CGRect(x: 0,  y:0, width: UIScreen.main.bounds.width-64, height: UIScreen.main.bounds.height*0.5)
        card.hardSizeWidth = UIScreen.main.bounds.width-64
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.6
        card.swipeLock = true
//        card.swipeLock = true
//        card.delegate = self
//        card.dataSource = self
        
        return card
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cardView.pin
            .top(to: contentView.edge.top)
            .left(to: contentView.edge.left)
            .right(to: contentView.edge.right)
            .bottom(to: contentView.edge.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

