import UIKit

final class ChatListViewController: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "chatList")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
