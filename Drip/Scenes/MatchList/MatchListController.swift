import UIKit

final class MatchListViewController: UIViewController, UIScrollViewDelegate, CardViewDelegate, CardViewDataSource {
    let model = FeedModel()
    
    func currentCard() -> Profile {
        return self.model.currentCard()!
    }
    
    func likedCurrent() {
        print("disliked")
    }
    
    func dislikedCurrent() {
        print("dislike")
    }
    
    func expandCurrent() {
        print("expand")
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "matchList")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Вы понравились нескольким людям"
        label.frame = CGRect(x: 0, y: 100, width:1, height: 200)
        
        return label
    }()
    
    let likesScroll = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        likesScroll.frame = CGRect(x:0, y: 200, width: view.frame.width*2, height: 600)
        
        let card = CardView()
        card.frame = CGRect(x: 12,  y:0, width: view.frame.width-64, height: view.frame.height*0.6)
        card.hardSizeWidth = view.frame.width-64
        card.hardSizeHeight = view.frame.height*0.6
        card.delegate = self
        card.swipeLock = true
        card.dataSource = self
        
        let card2 = CardView()
        card2.frame = CGRect(x: 340,  y:0, width: view.frame.width-64, height: view.frame.height*0.6)
        card2.hardSizeWidth = view.frame.width-64
        card2.hardSizeHeight = view.frame.height*0.6
        card2.swipeLock = true
        card2.delegate = self
        card2.dataSource = self
        

        view.addSubview(textLabel)
//        view.insertSubview(card, belowSubview: self.lastCard)
//        view.addSubview(card)
//        self.lastCard = card
        likesScroll.addSubview(card)
        likesScroll.addSubview(card2)
        
        textLabel.pin.bottom(to: likesScroll.edge.top)
        
        view.addSubview(likesScroll)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
