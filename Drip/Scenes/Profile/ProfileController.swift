import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    let settingsBtn: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "settings"), for: .normal)
            button.addTarget(self, action: #selector(touchSettingsBtn), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsBtn)
        settingsBtn.pin.right(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 30).height(50).width(50)
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
