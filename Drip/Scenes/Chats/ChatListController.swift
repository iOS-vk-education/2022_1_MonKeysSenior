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
    
    var matchesCount: Int = 0
    var chatsCount: Int = 0
    
    var matchesNames: [String] = []
    var matchesUrls: [String] = []
    
    var chatsNames: [String] = []
    var chatsUrls: [String] = []
    var chatsTexts: [String] = []
    
    func getMatches() {
        matchesRequest() { (result: Result) in
            switch result {
            case .success(let resObj):
                self.matchesCount = resObj?.allUsers.count ?? 0
                self.matchesNames = resObj!.allUsers.sorted(by: {$0.0 < $1.0}).map({item in item.value.name})
                self.matchesUrls = resObj!.allUsers.sorted(by: {$0.0 < $1.0}).map({item in "https://drip.monkeys.team/" + item.value.imgs[0]})
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSearchMatches(searchStr: String) {
        let searchObj = Search(searchTmpl: searchStr + "%");
        matchesRequest(search: searchObj) { (result: Result) in
            switch result {
            case .success(let resObj):
                self.matchesCount = resObj?.allUsers.count ?? 0
                self.matchesNames = resObj!.allUsers.sorted(by: {$0.0 < $1.0}).map({item in item.value.name})
                self.matchesUrls = resObj!.allUsers.sorted(by: {$0.0 < $1.0}).map({item in "https://drip.monkeys.team/" + item.value.imgs[0]})
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//                    self.matchCollectionView.reloadData()
//                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getChatsList() {
        chatsRequest() { (result: Result) in
            switch result {
            case .success(let resObj):
                self.chatsCount = resObj?.Chats.count ?? 0
                let sortedChats = resObj!.Chats.sorted(by: {$0.messages[0].date > $1.messages[0].date})
                self.chatsNames = sortedChats.map({item in item.name})
                self.chatsUrls = sortedChats.map({item in "https://drip.monkeys.team/" + item.img})
                self.chatsTexts = sortedChats.map({item in item.messages[0].text})
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMatches()
        getChatsList()
        
        sleep(1)
        
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
//        self.chatCollectionView.reloadData()
//        self.matchCollectionView.reloadData()
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
        if let searchText = searchController.searchBar.text {
            if searchText != "" {
                getSearchMatches(searchStr: searchText)
            } else {
                getMatches()
            }

            self.matchCollectionView.reloadData()
        }
    }
}

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == matchCollectionView {
            return matchesCount
        }
        else {
            return chatsCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == matchCollectionView {
            guard let cell = matchCollectionView.dequeueReusableCell(withReuseIdentifier: "MatchCollectionViewCell", for: indexPath) as? MatchCollectionViewCell else {
                return .init()
            }
            
            cell.configure(with: matchesUrls[indexPath.item], name: matchesNames[indexPath.item])
            
            return cell
        }
        else {
            guard let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: "ChatCollectionViewCell", for: indexPath) as? ChatCollectionViewCell else {
                return .init()
            }

            cell.configure(with: chatsUrls[indexPath.item], Name: chatsNames[indexPath.item], text: chatsTexts[indexPath.item])
            
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
