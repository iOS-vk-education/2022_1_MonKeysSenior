//
//  User.swift
//  Drip
//
//  Created by mikh.popov on 03.04.2022.
//

import Foundation

struct User: Codable {
    var id: UInt64
    var email: String
    var password: String?
    var gender: String
    var prefer: String
    var fromAge: Int
    var toAge: Int
    var date: String
    var age: Int
    var description: String
    var imgs: Array<String>
    var tags: Array<String>?
    var reportStatus: String?
    var payment: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case gender
        case prefer
        case fromAge = "fromage"
        case toAge = "toage"
        case date
        case age
        case description
        case imgs
        case tags
        case reportStatus
        case payment
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        do {
            try container.encode(password, forKey: .password)
        } catch {
            try container.encode("", forKey: .password)
        }
        try container.encode(gender, forKey: .gender)
        do {
            try container.encode(prefer, forKey: .prefer)
        } catch {
            try container.encode("", forKey: .prefer)
        }
        try container.encode(fromAge, forKey: .fromAge)
        try container.encode(toAge, forKey: .toAge)
        try container.encode(date, forKey: .date)
        try container.encode(age, forKey: .age)
        do {
            try container.encode(description, forKey: .description)
        } catch {
            try container.encode("", forKey: .prefer)
        }
        try container.encode(imgs, forKey: .imgs)
        do {
            try container.encode(tags, forKey: .tags)
        } catch {
            try container.encode("", forKey: .tags)
        }
        do {
            try container.encode(reportStatus, forKey: .reportStatus)
        } catch {
            try container.encode("", forKey: .reportStatus)
        }
        do {
            try container.encode(payment, forKey: .payment)
        } catch {
            try container.encode("", forKey: .payment)
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UInt64.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        do {
            password = try container.decode(String.self, forKey: .password)
        } catch {
            password = ""
        }
        gender = try container.decode(String.self, forKey: .gender)
        do {
            prefer = try container.decode(String.self, forKey: .prefer)
        } catch {
            prefer = ""
        }
        fromAge = try container.decode(Int.self, forKey: .fromAge)
        toAge = try container.decode(Int.self, forKey: .toAge)
        date = try container.decode(String.self, forKey: .date)
        age = try container.decode(Int.self, forKey: .age)
        do {
            description = try container.decode(String.self, forKey: .description)
        } catch {
            description = ""
        }
        imgs = try container.decode(Array<String>.self, forKey: .imgs)
        do {
            tags = try container.decode(Array<String>.self, forKey: .tags)
        } catch {
            tags = []
        }
        do {
            reportStatus = try container.decode(String.self, forKey: .reportStatus)
        } catch {
            reportStatus = ""
        }
        do {
            payment = try container.decode(Bool.self, forKey: .payment)
        } catch {
            payment = false
        }
    }
}
