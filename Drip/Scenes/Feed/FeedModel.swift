//
//  FeedModel.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import Foundation

final class FeedModel {
    private var cards: [Profile] = []
    
    func currentCard() -> Profile {
        return Profile(
            id: "1",
            name: "max",
            age: "24",
            description: "we re done",
            tags: ["hello", "self-hatred"],
            imgsURL: ["hello", "self-hatred"]
        )
    }
    
    func loadData(completion: (() -> Void)? = nil) {
        self.cards = [
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
