//
//  LikesCollectionViewCell.swift
//  Drip
//
//  Created by pierrelean on 20.04.2022.
//

import UIKit


protocol LikesViewCollectionCellDelegate: AnyObject {
    func remove(id: Int) -> Void
}

final class LikesCollectionViewCell: UICollectionViewCell, CardViewDelegate {
    
    
    weak var delegate: LikesViewCollectionCellDelegate?
    
    var card: User?
    
    
    func likedCurrent() {
        print("liked")
        print(self.card?.name)
        let id: Int = Int(self.card!.id)
        
        reactionRequest(reaction: Reaction(id: UInt64(id), reaction: 1), completion: {_ in } )
        self.delegate?.remove(id: id)
    }
    
    func dislikedCurrent() {
        print("disliked")
        print(self.card?.name)
        let id: Int = Int(self.card!.id)
        reactionRequest(reaction: Reaction(id: UInt64(id), reaction: 2), completion: {_ in } )
        self.delegate?.remove(id: id)
//        self.cardView.delegate?.likedCurrent()
    }
    
    func expandCurrent() {
        print("expand")
    }
    
    private let cardView: CardView = {
        let card = CardView()
//        card.frame = CGRect(x: 0,  y:0, width: UIScreen.main.bounds.width-64, height: UIScreen.main.bounds.height*0.5)
        card.hardSizeWidth = UIScreen.main.bounds.width-64
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.7
        card.swipeLock = true
        card.carouselLock = true
//        card.swipeLock = true
        
//        card.dataSource = self
        return card
    }()
    
    
    func configure(dataSource: CardViewDataSource, delegate: CardViewDelegate) {
        cardView.dataSource = dataSource
        self.card = dataSource.currentCard()
//        cardView.delegate = delegate
    }
    
    
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
        cardView.delegate = self
        contentView.addSubview(cardView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

