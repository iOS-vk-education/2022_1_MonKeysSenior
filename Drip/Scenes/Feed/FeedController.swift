import UIKit


final class FeedViewController: UIViewController {
    private let model = FeedModel()
    private let feedView = FeedView()
    private var _startCenter = CGPoint();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView.layer.cornerRadius = 12;
        feedView.delegate = self
        feedView.dataSource = self
        view.frame = CGRect(x:0, y:0 ,width: view.frame.width, height: view.frame.height)
        
        view.addSubview(feedView)
        feedView.frame = CGRect(x: 24, y:96, width: 350, height: 575)
        
        self.feedView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeHandler)))
        
        
    }
    
    @objc
    func swipeHandler(gesture: UIPanGestureRecognizer) {
//        print(gesture.location(in: self.view))
        
//        print(location.x)
//        print(view.frame.width/2-location.x)
//        feedView.transform = CGAffineTransform(rotationAngle: ((location.x-view.frame.width/2) * .pi) / 720)
        
       
        
        if(gesture.state == UIPanGestureRecognizer.State.began) {
            self._startCenter = feedView.center
        } else if (gesture.state == UIPanGestureRecognizer.State.changed) {
            print("helllo")
            let location = gesture.location(in: self.view)
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: location.x - self._startCenter.x, y: location.y - self._startCenter.y)
            
            transform = transform.rotated(by: ((location.x-view.frame.width/2) * .pi) / 720)
            feedView.transform = transform
//            feedView.center = locat
        }
        
        if(gesture.state == UIPanGestureRecognizer.State.ended){
            print("end")
            UIView.animate(withDuration: 1, animations: {
                self.feedView.transform = .identity
                self.feedView.center = self._startCenter
            })
            
        }
    }
}

extension FeedViewController: FeedViewDelegate {
    @objc
    func likedCurrent() {
        print("liked")
    }
    @objc
    func dislikedCurrent() {
        print("disliked")
    }
}

extension FeedViewController: FeedViewDataSource {
    func currentCard() -> Profile {
        return self.model.currentCard()
    }
}
