import UIKit
import PinLayout



class CardViewPrefetchDataSource: CardViewDataSource {
    var card: User?
    init(user: User) {
        self.card = user
    }
    func currentCard() -> User {
        return self.card!
    }
}

class CardViewPrefetchDelegate: CardViewDelegate {
    var card: User?
    init(user: User) {
        self.card = user
    }
    func likedCurrent() {
        print("like \(String(describing: self.card?.name)) \(String(describing: self.card?.id))")
    }
    func dislikedCurrent() {
        print("dislike \(String(describing: self.card?.name)) \(String(describing: self.card?.id))")
    }
    func expandCurrent() {
        print("expand")
    }
}



final class MatchListViewController: UIViewController, UIScrollViewDelegate, CardViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,LikesViewCollectionCellDelegate {
    
    
    let model = LikesModel()
    
    func remove(id: Int) {
        print("removing \(id)")
        _ = self.model.removeById(id: id)
        self.likesCollectionView.reloadData()
        
        if(self.model.getCards().count == 0) {
            outOfCards()
            self.textLabel.isHidden = true
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.getCards().count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        guard let cell = likesCollectionView.dequeueReusableCell(withReuseIdentifier: "LikesCollectionViewCell", for: indexPath) as? LikesCollectionViewCell
        
        else {
            print("check")
            return .init()
        }
        cell.delegate = self
        let dataSource = CardViewPrefetchDataSource(user: self.model.getCards()[indexPath.item])
        let delegateSource = CardViewPrefetchDelegate(user: self.model.getCards()[indexPath.item])
        cell.configure(dataSource: dataSource, delegate: delegateSource)
        
        return cell
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
    
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Вы понравились \nнескольким людям"
        label.frame = CGRect(x: 0, y: 100, width:400, height: 200)
        
        return label
    }()
    
    
    private func outOfCards() -> Void {
        let outOfCards = UIImageView()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "У вас пока нет лайков"
//            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = NSTextAlignment.center;
            label.textColor = .white
            label.frame = CGRect(x: 0, y: 200, width: 300, height: 100)
//            label.textAlignment = .
            
                
            return label
        }()
        
        outOfCards.image = UIImage(named: "heart_gradient")
        outOfCards.frame = CGRect(x: 200, y: 0, width: 200, height: 200)
        
        outOfCards.center = view.center
        descriptionLabel.center = view.center
        
        
        
//        descriptionLabel.pin.left(view.pin.safeArea.left + 20).top(view.pin.safeArea.top + 20).height(50).width(50)
        
        view.addSubview(outOfCards)
        view.addSubview(descriptionLabel)
    }
    
    private let likesCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        textLabel.pin
            .top(view.pin.safeArea)
            .left()
            .marginLeft(4%)
            .width(60%)
            .marginTop(5%)
            .sizeToFit()
        
        likesCollectionView.pin
            .below(of: textLabel)
            .height(80%)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .marginTop(1%)
            .marginLeft(1%)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        likesCollectionView.register(LikesCollectionViewCell.self, forCellWithReuseIdentifier: "LikesCollectionViewCell")
        
        likesCollectionView.dataSource = self
        likesCollectionView.delegate = self
        likesCollectionView.showsHorizontalScrollIndicator = false
        likesCollectionView.backgroundColor = .clear
    
        
        if(self.model.getCards().count == 0) {
            outOfCards()
            return
        }
        
        view.addSubview(textLabel)
        view.addSubview(likesCollectionView)
        
        
    
    }
}

extension MatchListViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width-64, height: UIScreen.main.bounds.height * 0.6)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 12
        }

        func collectionView(_ collectionView: UICollectionView, layout
            collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 12
        }
    }



import Foundation

final class LikesModel {
    private var cards: [User] = []
    private var counter: Int
    
    init(){
        self.counter = 0;
        
        loadData()
    }
    
    func getCards() -> [User] {
        return self.cards
    }
    
    func removeById(id: Int) -> Int {
        var ix: Int = 0
        for (element) in self.cards {
            if element.id == id {
                if(ix < self.cards.count) {
                    self.cards.remove(at: ix)
                }
               
                print("removed")
            }
            ix+=1
            
        }
        return ix-1
        
    }
    
    
    func loadData(completion: (() -> Void)? = nil) -> Void {
        print("likes")
        likesRequest(completion: { (result: Result) in
            switch result {
            case .success(let result):
                print(result as Any)
                self.cards = Array(result!.allUsers.values.map { $0 })
//                for (value) in result {
//                    self.cards.append(value)
//                }
                print("likes")
//                if ((result?.Users) != nil) {
//                    self.cards = result!.Users
//                }
            case .failure(let error):
                print(error)
                print("an error likes")
            }
        })
        
    }
}
