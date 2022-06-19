struct User: Codable {
    var id: UInt64
    var email: String
    var password: String
    var name: String
    var gender: String
    var prefer: String
    var fromAge: Int
    var toAge: Int
    var date: String
    var age: Int
    var description: String
    var imgs: Array<String>
    var tags: Array<String>
    var reportStatus: String
    var payment: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case name
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
        do {
            try container.encode(name, forKey: .name)
        } catch {
            try container.encode("", forKey: .name)
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
        do {
            name = try container.decode(String.self, forKey: .name)
        } catch {
            name = ""
        }
        do {
            gender = try container.decode(String.self, forKey: .gender)
        } catch {
            gender = ""
        }
        do {
            prefer = try container.decode(String.self, forKey: .prefer)
        } catch {
            prefer = ""
        }
        do {
            fromAge = try container.decode(Int.self, forKey: .fromAge)
        } catch {
            fromAge = 0
        }
        do {
            toAge = try container.decode(Int.self, forKey: .toAge)
        } catch {
            toAge = 0
        }
        do {
            date = try container.decode(String.self, forKey: .date)
        } catch {
            date = ""
        }
        do {
            age = try container.decode(Int.self, forKey: .age)
        } catch {
            age = 0
        }
        do {
            description = try container.decode(String.self, forKey: .description)
        } catch {
            description = ""
        }
        do {
            imgs = try container.decode(Array<String>.self, forKey: .imgs)
        } catch {
            imgs = []
        }
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

struct Users: Codable {
    var Users: [User] = Array();
}

