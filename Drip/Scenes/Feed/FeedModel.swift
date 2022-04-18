//
//  FeedModel.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import Foundation

final class FeedModel {
    private var cards: [Profile] = []
    private var counter: Int
    
    init(){
        self.counter = 0;
        self.cards = loadData()
    }
    
    func currentCard() -> Profile? {
        return self.cards[counter]
    }
    func next() -> Bool {
        counter+=1;
        return counter < self.cards.count
    }
    
    func loadData(completion: (() -> Void)? = nil) -> [Profile] {
        return [
            Profile(
                id: "1",
                name: "max",
                age: "24",
                description: "we re done",
                tags: ["hello", "self-hatred"],
                imgsURL: ["hello", "self-hatred"]
            ),
            Profile(
                id: "2",
                name: "john",
                age: "24",
                description: "we re done",
                tags: ["hello", "self-hatred"],
                imgsURL: ["hello", "self-hatred"]
            ),
            Profile(
                id: "3",
                name: "will",
                age: "24",
                description: "we re done",
                tags: ["hello", "self-hatred"],
                imgsURL: ["hello", "self-hatred"]
            )
        ]
        
    }
}
