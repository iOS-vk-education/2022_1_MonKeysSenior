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
        feedRequest(completion: { (result: Result) in
            switch result {
            case .success(let result):
                print(result)
                print("fuck")
            case .failure(let error):
                print(error)
                print("an error")
            }
        })
        return [
            Profile(
                id: "1",
                name: "Elon",
                age: "34",
                description: "Entre-preneur",
                tags: ["hello", "self-hatred"],
                imgsURL: ["https://www.ixbt.com/img/n1/news/2021/6/4/29musk-1-mediumSquareAt3X_large.jpg", "self-hatred"]
            ),
            Profile(
                id: "2",
                name: "Tim",
                age: "48",
                description: "apple",
                tags: ["hello", "self-hatred"],
                imgsURL: ["https://i-ekb.ru/wp-content/uploads/2022/01/41192-79817-000-lead-tim-cook-xl.jpg", "self-hatred"]
            ),
            Profile(
                id: "3",
                name: "will",
                age: "24",
                description: "we re done",
                tags: ["hello", "self-hatred"],
                imgsURL: ["https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY2MzU3OTcxMTUwODQxNTM1/steve-jobs--david-paul-morrisbloomberg-via-getty-images.jpg", "self-hatred"]
            ),
            Profile(
                id: "4",
                name: "will",
                age: "24",
                description: "we re done",
                tags: ["hello", "self-hatred"],
                imgsURL: ["https://cdnn21.img.ria.ru/images/07e6/04/07/1782363753_0:209:3101:1953_1920x0_80_0_0_ada329428b04bcdd69222abc29a7abde.jpg", "self-hatred"]
            )
        ]
        
    }
}
