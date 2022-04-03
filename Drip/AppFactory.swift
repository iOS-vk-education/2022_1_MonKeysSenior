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
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.tintColor = .black
        return tabBarController
    }
    
    private func buildFeedViewController() -> UIViewController {
        let feed = FeedViewController()
        let feedItem = UITabBarItem(title: "Лента", image: UIImage(named: "feedIcon"), selectedImage: nil)
        feed.tabBarItem = feedItem
        return feed
    }
    
    private func buildMatchListViewController() -> UIViewController {
        let matchList = MatchListViewController()
        let matchListItem = UITabBarItem(title: "Совпадения", image: UIImage(named: "matchListIcon"), selectedImage: nil)
        matchList.tabBarItem = matchListItem
        return matchList
    }
    
    private func buildChatListViewController() -> UIViewController {
        let chatList = ChatListViewController()
        let chatListItem = UITabBarItem(title: "Чаты", image: UIImage(named: "chatListIcon"), selectedImage: nil)
        chatList.tabBarItem = chatListItem
        return chatList
    }
    
    private func buildProfileViewController() -> UIViewController {
        let profile = ProfileViewController()
        let profileItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profileIcon"), selectedImage: nil)
        profile.tabBarItem = profileItem

        loginRequest(credentials: Credentials(email: "lol", password: "prikol")) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
            case .failure(let error):
                print(error)
            }
        }

        return profile
    }
    
}
