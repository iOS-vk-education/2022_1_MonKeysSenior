import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let factory = AppFactory()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .cyan
        
        window?.backgroundColor = .white
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
        layer0.bounds = window!.bounds
//        layer0.position = window!.center
        window?.layer.addSublayer(layer0)
        print(layer0.bounds)
//        let root = factory.buildTabBarController()
        let root = factory.buildLoginViewController();
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }
}
