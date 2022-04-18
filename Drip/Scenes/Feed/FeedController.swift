import UIKit


final class FeedViewController: UIViewController {
    private let model = FeedModel()
//    private var lastCard = CardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        lastCard.layer.cornerRadius = 12;
//        lastCard.delegate = self
//        lastCard.dataSource = self
//        feedView.superview = self
        
        
        view.frame = CGRect(x:0, y:0 ,width: view.frame.width, height: view.frame.height)
//        view.addSubview(lastCard)
//
//
//        lastCard.frame = CGRect(x: 12, y:64, width: view.frame.width-24, height: view.frame.height*0.9)
//
//        lastCard.hardSizeWidth = view.frame.width-24
//        lastCard.hardSizeHeight = view.frame.height*0.9
//        lastCard.layoutIfNeeded()
        addCardToStack()
    }
    
    
    
    private func addCardToStack() -> Void {
        let card = CardView()
//        print(view)
        card.frame = CGRect(x: 12,  y:64, width: UIScreen.main.bounds.width-24, height: UIScreen.main.bounds.height*0.8)
        card.hardSizeWidth = UIScreen.main.bounds.width-24
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.8
        card.delegate = self
        card.dataSource = self
        
//        view.insertSubview(card, belowSubview: self.lastCard)
        view.addSubview(card)
//        self.lastCard = card
        
    }
    private func outOfCards() -> Void {
        let outOfCards = UIImageView()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Карточки кончились"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = NSTextAlignment.center;
            label.textColor = .white
            label.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
                
            return label
        }()
        
        outOfCards.image = UIImage(named: "drip_gradient")
        outOfCards.frame = CGRect(x: 0, y: 0, width: 120, height: 200)
        
        outOfCards.center = view.center
        view.addSubview(descriptionLabel)
        
        view.addSubview(outOfCards)
        descriptionLabel.center = view.center
        descriptionLabel.pin.top(to: outOfCards.edge.bottom)
    }
    
    
}

extension FeedViewController: CardViewDelegate {
    @objc
    func likedCurrent() {
        print("liked")
        if (self.model.next()){
            self.addCardToStack()
        } else {
            outOfCards()
        }
//        self.lastCard.removeFromSuperview()
//        addCardToStack(data: self.model.currentCard())
    }
    @objc
    func dislikedCurrent() {
        print("disliked")
        if (self.model.next()){
            self.addCardToStack()
        } else {
            outOfCards()
        }
//        self.lastCard.removeFromSuperview()
//        addCardToStack(data: self.model.currentCard())
    }
    @objc
    func expandCurrent() {
        print("disliked")
    }
}

extension FeedViewController: CardViewDataSource {
    func currentCard() -> Profile {
        return self.model.currentCard()!
    }
}
