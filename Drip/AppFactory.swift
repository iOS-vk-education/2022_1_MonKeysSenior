import UIKit

final class AppFactory {
    func buildTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            buildFeedViewController(),
            buildMatchListViewController(),
            buildChatListViewController(),
            buildProfileViewController()
        ]
        
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.isTranslucent = false
//        tabBarController.tabBar.backgroundColor = r
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.tintColor = .white
        return tabBarController
    }
    
    func buildLoginViewController() -> UIViewController {
        let login = LoginViewController()
        return login
    }
    
    func buildSignupViewController() -> UIViewController {
        let signup = SignupViewController()
        return signup
    }
    
    private func buildFeedViewController() -> UIViewController {
        let feed = FeedViewController()
        let feedItem = UITabBarItem(title: "", image: UIImage(named: "feedIcon"), selectedImage: nil)
        feed.tabBarItem = feedItem
        return feed
    }
    
    private func buildMatchListViewController() -> UIViewController {
        let matchList = MatchListViewController()
        let matchListItem = UITabBarItem(title: "", image: UIImage(named: "matchListIcon"), selectedImage: nil)
        matchList.tabBarItem = matchListItem
        return matchList
    }
    
    private func buildChatListViewController() -> UIViewController {
        let chatList = ChatListViewController()
        let chatListItem = UITabBarItem(title: "", image: UIImage(named: "chatListIcon"), selectedImage: nil)
        chatList.tabBarItem = chatListItem
        return chatList
    }
    
    private func buildProfileViewController() -> UIViewController {
        let profile = ProfileViewController()
        let profileItem = UITabBarItem(title: "", image: UIImage(named: "profileIcon"), selectedImage: nil)
        profile.tabBarItem = profileItem
        
        // example
//        loginRequest(credentials: Credentials(email: "mumeu222@mail.ru", password: "vbif2222")) { (result: Result) in
//            switch result {
//            case .success(let object):
//                print(object)
//
//                // example
//                getProfileRequest() { (result: Result) in
//                    switch result {
//                    case .success(let object):
//                        print(object)
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        return profile
    }
    
}
