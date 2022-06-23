import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    let factory = AppFactory()
    let model = ProfileModel()
    let refreshControl = UIRefreshControl()
    
    let settingsBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(touchSettingsBtn), for: .touchUpInside)
        return button
    }()
    
    let logoutBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(touchLogoutBtn), for: .touchUpInside)
        return button
    }()
    
    let card = CardView()
    
    var scrollView: UIScrollView?
    
    @objc func refresh(_ sender: AnyObject) {
       print("refresh")
        model.refresh()
        card.removeFromSuperview()
        sleep(1)
//        self.model.update()
        //self.likesCollectionView.reloadData()
//        self.viewDidLoad()
        
        
//        viewDidLoad()
        card.frame = CGRect(x: 12,  y:104, width: UIScreen.main.bounds.width-24, height: UIScreen.main.bounds.height*0.7)
        card.hardSizeWidth = UIScreen.main.bounds.width-24
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.7
        card.delegate = self
        card.dataSource = self
        card.swipeLock = true
        card.reactionsEnabled = false
//        card.center = CGPoint(x: view.center.x, y: -view.center.y * 4)
//        view.insertSubview(card, belowSubview: self.lastCard)
        scrollView!.addSubview(card)
        
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView!.refreshControl = refreshControl
        scrollView!.addSubview(refreshControl)
        view.addSubview(scrollView!)
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        scrollView!.addSubview(settingsBtn)
        scrollView!.addSubview(logoutBtn)
        logoutBtn.pin.left(view.pin.safeArea.left + 20).top(view.pin.safeArea.top + 50).height(50).width(50)
        settingsBtn.pin.right(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 50).height(50).width(50)
        
        
        
        card.frame = CGRect(x: 12,  y:104, width: UIScreen.main.bounds.width-24, height: UIScreen.main.bounds.height*0.7)
        card.hardSizeWidth = UIScreen.main.bounds.width-24
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.7
        card.delegate = self
        card.dataSource = self
        card.swipeLock = true
        card.reactionsEnabled = false
//        card.center = CGPoint(x: view.center.x, y: -view.center.y * 4)
//        view.insertSubview(card, belowSubview: self.lastCard)
        scrollView!.addSubview(card)
        
        
       
    }
    
    @objc
    func touchSettingsBtn() {
        
           let profileController = ProfileSettingsViewController()
           let navController = UINavigationController(rootViewController: profileController)
           navController.navigationBar.barStyle = .black
           navController.modalPresentationStyle = .fullScreen
           UIView.animate(withDuration: 1, animations:  {
               profileController.view.layoutSubviews()
           })
           present(navController, animated: false)
    }
    
    @objc
    func touchLogoutBtn() {
        print("logout")
        let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: "https://drip.monkeys.team/api/v1")!)
                for cookie in cookies ?? [] {
                    HTTPCookieStorage.shared.deleteCookie(cookie as HTTPCookie)
        }
        
        let profileController = LoginViewController()
           let navController = UINavigationController(rootViewController: profileController)
           navController.navigationBar.barStyle = .black
           navController.modalPresentationStyle = .fullScreen
           UIView.animate(withDuration: 1, animations:  {
               profileController.view.layoutSubviews()
        })
        present(navController, animated: false)
    }
    
//    func restartApplication () {
////        let viewController = LaunchScreenViewController()
////        let navCtrl = UINavigationController(rootViewController: viewController)
////
////        guard
////            let window = UIApplication.shared.keyWindow,
////            let rootViewController = window.rootViewController
////
////        else {
////            return
////        }
////
////        navCtrl.view.frame = rootViewController.view.frame
////        navCtrl.view.layoutIfNeeded()
////
////        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
////            window.rootViewController = navCtrl
////        })
//    }
}




extension ProfileViewController: CardViewDelegate {
    @objc
    func likedCurrent() {
        print("liked")
    }
    @objc
    func dislikedCurrent() {
        print("disliked")
    }
    @objc
    func expandCurrent() {
        print("disliked")
    }
}

extension ProfileViewController: CardViewDataSource {
    func currentCard() -> User {
        return self.model.currentCard()!
    }
}






import Foundation

final class ProfileModel {
    private var card: User?
    
    init(){
        loadData()
    }
    
    func refresh() -> Void {
        loadData()
    }
    
    func currentCard() -> User? {
        return self.card
    }
    
    func loadData(completion: (() -> Void)? = nil) -> Void {
        getProfileRequest(completion: { (result: Result) in
            switch result {
            case .success(let result):
                self.card = result!
            case .failure(let error):
                print(error)
                print("an error")
            }
        })
        
    }
}
