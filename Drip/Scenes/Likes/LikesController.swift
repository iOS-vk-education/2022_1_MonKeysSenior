import UIKit
import PinLayout

final class MatchListViewController: UIViewController, UIScrollViewDelegate, CardViewDelegate, CardViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = likesCollectionView.dequeueReusableCell(withReuseIdentifier: "LikesCollectionViewCell", for: indexPath) as? LikesCollectionViewCell else {
            print("check")
            return .init()
        }
        
        return cell
    }
    
    
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
    
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "Вы понравились \nнескольким людям"
        label.frame = CGRect(x: 0, y: 100, width:1, height: 200)
        
        return label
    }()
    
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
