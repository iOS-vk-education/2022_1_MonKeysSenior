//
//  File.swift
//  Drip
//
//  Created by pierrelean on 05.04.2022.
//

import Foundation

struct Profile: Codable {
    let id: String
    var name: String
    var age: String
    var description: String
    var tags: [String]
    var imgsURL: [String]
}
