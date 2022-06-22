import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    let factory = AppFactory()

    let logoutBtn: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "settings"), for: .normal)
            button.addTarget(self, action: #selector(touchLogoutBtn), for: .touchUpInside)
            return button
    }()

    let settingsBtn: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "settings"), for: .normal)
            button.addTarget(self, action: #selector(touchSettingsBtn), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoutBtn)
        view.addSubview(settingsBtn)
        logoutBtn.pin.left(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 60).height(50).width(50)
        settingsBtn.pin.right(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 60).height(50).width(50)
    }
    
    @objc
    func touchLogoutBtn() {
        presentingViewController?.dismiss(animated: true, completion: nil)
        let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: "https://drip.monkeys.team/api/v1")!)
        for cookie in cookies ?? [] {
            HTTPCookieStorage.shared.deleteCookie(cookie as HTTPCookie)
        }

        let loginController = factory.buildLoginViewController()
        let navController = UINavigationController(rootViewController: loginController)
        loginController.modalTransitionStyle = .flipHorizontal
        loginController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
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
}
