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
        sleep(1)
        if(self.model.hasCards()){
            addCardToStack()
        } else {
            outOfCards()
        }
    }
    
    
    
    private func addCardToStack() -> Void {
        let card = CardView()
//        print(view)
        card.frame = CGRect(x: 12,  y:64, width: UIScreen.main.bounds.width-24, height: UIScreen.main.bounds.height*0.8)
        card.hardSizeWidth = UIScreen.main.bounds.width-24
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.8
        card.delegate = self
        card.dataSource = self
        card.layer.opacity = 0.1
//        card.center = CGPoint(x: view.center.x, y: -view.center.y * 4)
//        view.insertSubview(card, belowSubview: self.lastCard)
        view.addSubview(card)
        UIView.animate(withDuration: 2, animations: {
            card.layer.opacity = 1
//            card.center = self.view.center
        })
//        self.lastCard = card
        
    }
    private func outOfCards() -> Void {
        let outOfCards = UIImageView()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Карточки кончились"
//            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = NSTextAlignment.center;
            label.textColor = .white
            label.frame = CGRect(x: 0, y: 200, width: 300, height: 100)
//            label.textAlignment = .
            
                
            return label
        }()
        
        outOfCards.image = UIImage(named: "drip_gradient")
        outOfCards.frame = CGRect(x: 200, y: 0, width: 120, height: 200)
        
        outOfCards.center = view.center
        descriptionLabel.center = view.center
        
        
        
//        descriptionLabel.pin.left(view.pin.safeArea.left + 20).top(view.pin.safeArea.top + 20).height(50).width(50)
        
        view.addSubview(outOfCards)
        view.addSubview(descriptionLabel)
    }
    
    
}

extension FeedViewController: CardViewDelegate {
    @objc
    func likedCurrent() {
        print("liked")
        print(self.model.currentCard()!.id)
        reactionRequest(reaction: Reaction(id: self.model.currentCard()!.id, reaction: 1), completion: {_ in } )
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
        reactionRequest(reaction: Reaction(id: self.model.currentCard()!.id, reaction: 2), completion: {_ in } )
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
    func currentCard() -> User {
        return self.model.currentCard()!
    }
}
