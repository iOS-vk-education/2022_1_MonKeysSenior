import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "profile")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let settingsBtn: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "settings"), for: .normal)
            button.addTarget(self, action: #selector(touchSettingsBtn), for: .touchUpInside)
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(settingsBtn)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        settingsBtn.pin.right(view.pin.safeArea.right + 20).top(view.pin.safeArea.top + 20).height(50).width(50)
    }
    
    @objc
    func touchSettingsBtn() {
        print("hui")
        let profileController = ProfileFormController()
        profileController.title = "Hui"
        let navController = UINavigationController(rootViewController: profileController)
        navController.navigationBar.barStyle = .black
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: false)
    }
}
