import UIKit
import PinLayout

final class ChatViewController: UIViewController {
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "HELLO"
        let layer0 = CAGradientLayer()
        layer0.colors = [
                  UIColor(red: 0.059, green: 0.067, blue: 0.235, alpha: 1).cgColor,
                  UIColor(red: 0.278, green: 0.161, blue: 0.545, alpha: 1).cgColor,
                  UIColor(red: 0.694, green: 0.039, blue: 0.792, alpha: 1).cgColor
                ]
        layer0.locations = [0, 0.46, 1]
        layer0.startPoint = CGPoint(x: 0, y: 0)
        layer0.endPoint = CGPoint(x: 1, y: 1)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 5, c: -1, d: 0, tx: 1, ty: 1))
        layer0.frame = view.bounds
        view.layer.addSublayer(layer0)
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        label.pin
            .center()
            .sizeToFit()
    }
}
