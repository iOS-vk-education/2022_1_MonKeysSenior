//
//  FeedVIew.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import UIKit
import PinLayout
import Kingfisher


protocol CardViewDelegate: AnyObject {
    func likedCurrent()
    func dislikedCurrent()
    func expandCurrent()
}

protocol CardViewDataSource: AnyObject {
    func currentCard() -> Profile
}

final class CardView: UIView {
    
    weak var delegate: CardViewDelegate?
    
    var hardSizeWidth: CGFloat?
    
    var hardSizeHeight: CGFloat?
    
    var swipeLock: Bool?
    
    private var _startCenter = CGPoint();
    
    private let bottomPanelView: UIView = {
        let container = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 350, height: 135)
        container.layer.cornerRadius = 12
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.7
        blurEffectView.frame = container.frame
        blurEffectView.layer.cornerRadius = 12 
        blurEffectView.clipsToBounds = true
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(blurEffectView)
        
        return container
    }()
    
    
    private let cardContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .red
        return container
    }()
    
    private var cardImage: UIImageView = {
        let url = URL(string: "https://cdnimg.rg.ru/img/content/222/64/81/8961287_d_850.jpg")
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.kf.setImage(with: url)
        image.frame = CGRect(x:0, y:0, width: 350, height: 575)
        image.layer.cornerRadius = 12;
        image.clipsToBounds = true
        
        
        return image
    }()
    
    
    
    private func cardImageGeneratior(url: String) -> UIImageView {
        let url = URL(string: url)
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.kf.setImage(with: url)
        image.frame = CGRect(x:0, y:0, width: 350, height: 575)
        image.layer.cornerRadius = 12;
        image.clipsToBounds = true
        
        
        return image
    }
    
    
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "27"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Влад"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
            
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание выглядит вот \n так вот так оно и выглядит"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
            
        return label
    }()
    
    let tagsView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center;
        label.layer.cornerRadius = 12;
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        label.text = "Спорт"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 36)
            
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
    
    
    weak var dataSource: CardViewDataSource? {
        didSet {
            
            self.ageLabel.text = dataSource?.currentCard().age
            self.nameLabel.text = dataSource?.currentCard().name
            self.descriptionLabel.text = dataSource?.currentCard().description
            self.tagsView.text = dataSource?.currentCard().tags[0]
            let url = URL(string: (dataSource?.currentCard().imgsURL[0])!)
            self.cardImage.kf.setImage(with: url)
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.layer.cornerRadius = 12
        blurEffectView.clipsToBounds = true

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        addSubview(descriptionLabel)
        addSubview(tagsView)
        
        addSubview(cardContainerView)
        
        
    
        
        likeButton.addTarget(self, action: #selector(likedCurrent), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikedCurrent), for: .touchUpInside)
        expandButton.addTarget(self, action: #selector(expandCurrent), for: .touchUpInside)
//        expandButton
        
        addSubview(likeButton)
        addSubview(dislikeButton)
        addSubview(expandButton)
        
        cardContainerView.addSubview(cardImage)
        cardContainerView.addSubview(bottomPanelView)
        
        bottomPanelView.addSubview(nameLabel)
        bottomPanelView.addSubview(ageLabel)
        layoutShrink()
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeHandler)))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func likedCurrent() {
        print("liked current")
        
        UIView.animate(withDuration: 1, animations: {
            self.transform = .identity
            self.center = CGPoint(x: self.hardSizeWidth! * 2, y: self.center.y)
            self.delegate?.likedCurrent()
        })
    }
    
    @objc
    private func dislikedCurrent() {
        
        UIView.animate(withDuration: 1, animations: {
            self.transform = .identity
            self.center = CGPoint(x: self.hardSizeWidth! * -2, y: self.center.y)
            self.delegate?.dislikedCurrent()
        })
        
    }
    
    @objc
    private func expandCurrent() {
        print("ayo")
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutExpanded()
        })
    }
    
    
    
    
    @objc
    public func shrinkCurrent() {
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutShrink()
        })
    }
    
    override func layoutSubviews() {
        print("hello")
        super.layoutSubviews()
        layoutCardItems()
//        button.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: frame.height / 2))
    }
    
    private func layoutShrink() {
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: (0))
        self.expandButton.imageView?.transform = transform
        self.cardImage.frame = CGRect(x:0, y:0, width: self.hardSizeWidth ?? 350, height: self.hardSizeHeight ?? 550)
        bottomPanelView.pin.bottom(to: cardImage.edge.bottom)
        self.expandButton.pin.hCenter(to: self.cardImage.edge.hCenter)
        self.expandButton.pin.below(of: self.nameLabel)
        self.dislikeButton.pin.left(of: self.expandButton).top(to: self.nameLabel.edge.bottom).marginRight(36)
        self.likeButton.pin.right(of: self.expandButton).top(to: self .nameLabel.edge.bottom).marginLeft(36)
        
        self.descriptionLabel.pin.top(to: self.cardImage.edge.top).left(10)
        self.tagsView.pin.top(to: self.cardImage.edge.top).left(10)
        
        self.expandButton.addTarget(self, action: #selector(self.expandCurrent), for: .touchUpInside)
    }
    
    private func layoutExpanded() {
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: (.pi))
        self.expandButton.imageView?.transform = transform
        self.cardImage.frame = CGRect(x:0, y:0, width: self.hardSizeWidth!, height: self.hardSizeHeight!-200)
        
        self.bottomPanelView.pin.bottom(to: cardImage.edge.bottom)
        self.expandButton.pin.hCenter(to: self.cardImage.edge.hCenter)
       
        self.expandButton.pin.hCenter(to: self.cardImage.edge.hCenter)
        self.expandButton.pin.below(of: self.nameLabel)
        self.dislikeButton.pin.left(of: self.expandButton).top(to: self.nameLabel.edge.bottom).marginRight(36)
        self.likeButton.pin.right(of: self.expandButton).top(to: self .nameLabel.edge.bottom).marginLeft(36)
        
        self.descriptionLabel.pin.top(to: self.bottomPanelView.edge.bottom).left(10)
        self.tagsView.pin.top(to: self.descriptionLabel.edge.bottom).left(10)
        
        self.expandButton.addTarget(self, action: #selector(self.shrinkCurrent), for: .touchUpInside)
    }
    
    @objc
    func swipeHandler(gesture: UIPanGestureRecognizer) {
        if(self.swipeLock ?? false){
            return
        }
        if(gesture.state == UIPanGestureRecognizer.State.began) {
            self._startCenter = self.center
            shrinkCurrent()
            print("check")
        } else if (gesture.state == UIPanGestureRecognizer.State.changed) {

            let location = gesture.location(in: self.superview)
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: location.x - self._startCenter.x, y: location.y - self._startCenter.y)
            
            print(location.x-self.hardSizeWidth!/2)
            transform = transform.rotated(by: ((location.x-self.hardSizeWidth!/2) * .pi) / 720)
            self.transform = transform
//            feedView.center = locat
        }
        
        if(gesture.state == UIPanGestureRecognizer.State.ended){
            
            let offset = gesture.location(in: self.superview).x-self.hardSizeWidth!/2
            if  offset < -50 {
                self.dislikedCurrent()
            } else if offset > 50 {
                self.likedCurrent()
            } else {
                UIView.animate(withDuration: 1, animations: {
                    self.transform = .identity
                    self.center = self._startCenter
                })
            }
            
        }
    }
    
    private func layoutCardItems() {
        self.bottomPanelView.frame = CGRect(x: 0, y: 0, width: self.hardSizeWidth!, height: self.hardSizeHeight! * 0.18)
        self.cardImage.frame = CGRect(x:0, y:0, width: self.hardSizeWidth!, height: self.hardSizeHeight!)
        self.cardContainerView.pin.top(0).hCenter().width(100%).maxWidth(400).pinEdges()
        self.bottomPanelView.pin.bottom(to: self.cardImage.edge.bottom)
        self.nameLabel.pin.left(to: self.bottomPanelView.edge.left).marginLeft(24)
        self.nameLabel.pin.top(to: self.bottomPanelView.edge.top)
        
        self.ageLabel.pin.left(to: self.nameLabel.edge.right)
        self.ageLabel.pin.top(to: self.bottomPanelView.edge.top)
      
        self.expandButton.pin.hCenter(to: self.cardImage.edge.hCenter)
        self.expandButton.pin.below(of: self.nameLabel)
        self.dislikeButton.pin.left(of: self.expandButton).top(to: self.nameLabel.edge.bottom).marginRight(36)
        self.likeButton.pin.right(of: self.expandButton).top(to: self .nameLabel.edge.bottom).marginLeft(36)
    }
}
