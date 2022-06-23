//
//  FeedModel.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import Foundation

final class FeedModel {
    private var cards: [User] = []
    private var counter: Int
    
    init(){
        self.counter = 0;
        
        loadData()
    }
    
    func currentCard() -> User? {
//        sleep(1)
        if self.cards.count - counter < 2 {
            self.counter = 0;
            loadData()
        }
        return self.cards[counter]
    }
    func next() -> Bool {
        counter+=1;
        return counter < self.cards.count
    }
    
    func hasCards() -> Bool {
        return counter < self.cards.count
    }
    
    func loadData(completion: (() -> Void)? = nil) -> Void {
        feedRequest(completion: { (result: Result) in
            switch result {
            case .success(let result):
                print(result as Any)
                print("fuck")
                if ((result?.Users) != nil) {
                    self.cards = result!.Users
                }
            case .failure(let error):
                print(error)
                print("an error")
            }
        })
        
    }
}
