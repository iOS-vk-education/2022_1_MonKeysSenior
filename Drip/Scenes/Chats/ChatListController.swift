import UIKit
import PinLayout

final class ChatListViewController: UIViewController {
    private let matchesLabel = UILabel()
    private let chatsLabel = UILabel()
    
    private lazy var searchChatController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.searchBar.placeholder = "Поиск"
        sc.searchBar.barStyle = .black
        return sc
    }()
    
    private let matchCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal

        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    private let chatCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical

        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    var urls: [String] = [
        "https://is4-ssl.mzstatic.com/image/thumb/Purple123/v4/8e/47/7c/8e477c39-39b7-7cdf-0a49-999131ed996a/source/512x512bb.jpg",
        "https://cdn.jim-nielsen.com/ios/1024/weather-fine-2016-03-15.png",
        "https://iphone-image.apkpure.com/v2/app/0/4/2/042a955bdd194eaca834a948127ae474.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchChatController.searchBar
        searchChatController.hidesNavigationBarDuringPresentation = false
        
        matchesLabel.text = "Ваши пары"
        matchesLabel.font = .boldSystemFont(ofSize: 26)
        
        chatsLabel.text = "Чаты"
        chatsLabel.font = .boldSystemFont(ofSize: 26)
                
        matchCollectionView.dataSource = self
        matchCollectionView.delegate = self
        matchCollectionView.showsHorizontalScrollIndicator = false
        matchCollectionView.backgroundColor = .clear
        
        matchCollectionView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: "MatchCollectionViewCell")
        
        chatCollectionView.dataSource = self
        chatCollectionView.delegate = self
        chatCollectionView.showsVerticalScrollIndicator = false
        chatCollectionView.backgroundColor = .clear
        
        chatCollectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: "ChatCollectionViewCell")
        
        view.addSubview(matchesLabel)
        view.addSubview(matchCollectionView)
        view.addSubview(chatsLabel)
        view.addSubview(chatCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        matchesLabel.pin
            .top(view.pin.safeArea)
            .left()
            .marginLeft(4%)
            .marginTop(1%)
            .sizeToFit()
        matchCollectionView.pin
            .below(of: matchesLabel)
            .height(15%)
            .marginLeft(4%)
            .marginTop(1%)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
        chatsLabel.pin
            .below(of: matchCollectionView)
            .marginTop(2%)
            .left()
            .marginLeft(4%)
            .sizeToFit()
        chatCollectionView.pin
            .below(of: chatsLabel)
            .marginLeft(4%)
            .marginRight(4%)
            .marginTop(1%)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .bottom(view.pin.safeArea)
    }
    
    private func chatOpen() {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
       
    }
}

extension ChatListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//                    filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//                        return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//                    })
//
//                    tableView.reloadData()
//                }
    }
}

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == matchCollectionView {
            return 50
        }
        else {
            return 50
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == matchCollectionView {
            guard let cell = matchCollectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath) as? MatchCollectionViewCell else {
                return .init()
            }
            
            cell.configure(with: urls[indexPath.item % urls.count])
            
            return cell
        }
        else {
            guard let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: "ChatCollectionViewCell", for: indexPath) as? ChatCollectionViewCell else {
                return .init()
            }
            
            cell.configure(with: urls[indexPath.item % urls.count])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == matchCollectionView {
            let availableHeight = matchCollectionView.bounds.height
            let availableWidth = availableHeight * 0.84
            
            return CGSize(width: availableWidth, height: availableHeight)
        }
        else {
            let availableHeight = 90.0
            let availableWidth = chatCollectionView.bounds.width
            
            return CGSize(width: availableWidth, height: availableHeight)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == matchCollectionView {
            return 12
        }
        else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chatOpen()
    }
}
