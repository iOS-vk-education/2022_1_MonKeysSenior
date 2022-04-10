import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let factory = AppFactory()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
//        let root = factory.buildTabBarController()
        let root = factory.buildLoginViewController()
//        let root = factory.buildSignupViewController()
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }
}
