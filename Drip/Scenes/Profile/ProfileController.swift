import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    let factory = AppFactory()
    let model = ProfileModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsBtn)
        view.addSubview(logoutBtn)
        logoutBtn.pin.left(view.pin.safeArea.left + 20).top(view.pin.safeArea.top + 20).height(50).width(50)
        settingsBtn.pin.right(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 20).height(50).width(50)
        
        let card = CardView()
        
        card.frame = CGRect(x: 12,  y:64, width: UIScreen.main.bounds.width-24, height: UIScreen.main.bounds.height*0.8)
        card.hardSizeWidth = UIScreen.main.bounds.width-24
        card.hardSizeHeight = UIScreen.main.bounds.height * 0.8
        card.delegate = self
        card.dataSource = self
        card.swipeLock = true
        card.reactionsEnabled = false
//        card.center = CGPoint(x: view.center.x, y: -view.center.y * 4)
//        view.insertSubview(card, belowSubview: self.lastCard)
        view.addSubview(card)
    }
    
    @objc
    func touchSettingsBtn() {
        let profileController = ProfileSettingsController()
        let navController = UINavigationController(rootViewController: profileController)
        navController.navigationBar.barStyle = .black
        navController.modalPresentationStyle = .fullScreen
        UIView.animate(withDuration: 1, animations:  {
            profileController.view.layoutSubviews()
        }
        )
        present(navController, animated: false)
    }
    @objc
    func touchLogoutBtn() {
        print("logout")
        logoutRequest(completion: { (result: Result) in
            switch result {
            case .success(_):
                let signupController = self.factory.buildSignupViewController()
                signupController.modalTransitionStyle = .flipHorizontal
                signupController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(signupController, animated: true, completion: nil)
            case .failure(let error):
                print(error)
                print("an error")
            }
        })
    }
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
