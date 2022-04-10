import UIKit

final class AppFactory {
    func buildLoginViewController() -> UIViewController {
        let login = LoginViewController()
        return login
    }
    
    func buildSignupViewController() -> UIViewController {
        let signup = SignupViewController()
        return signup
    }
    
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
        return profile
    }
    
}
