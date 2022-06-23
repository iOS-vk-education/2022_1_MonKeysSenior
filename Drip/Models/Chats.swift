struct Messages: Codable {
    var messageID: UInt64
    var fromID: UInt64
    var toID: UInt64
    var text: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case messageID
        case fromID
        case toID
        case text
        case date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(messageID, forKey: .messageID)
        try container.encode(fromID, forKey: .fromID)
        try container.encode(toID, forKey: .toID)
        do {
            try container.encode(text, forKey: .text)
        } catch {
            try container.encode("", forKey: .text)
        }
        try container.encode(date, forKey: .date)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        messageID = try container.decode(UInt64.self, forKey: .messageID)
        fromID = try container.decode(UInt64.self, forKey: .fromID)
        toID = try container.decode(UInt64.self, forKey: .toID)
        do {
            text = try container.decode(String.self, forKey: .text)
        } catch {
            text = ""
        }
        date = try container.decode(String.self, forKey: .date)
    }
}

struct Chat: Codable {
    var fromUserID: UInt64
    var name: String
    var img: String
    var messages: Array<Messages>
    
    enum CodingKeys: String, CodingKey {
        case fromUserID
        case name
        case img
        case messages
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fromUserID, forKey: .fromUserID)
        do {
            try container.encode(name, forKey: .name)
        } catch {
            try container.encode("", forKey: .name)
        }
        try container.encode(img, forKey: .img)
        try container.encode(messages, forKey: .messages)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        fromUserID = try container.decode(UInt64.self, forKey: .fromUserID)
        do {
            name = try container.decode(String.self, forKey: .name)
        } catch {
            name = ""
        }
        img = try container.decode(String.self, forKey: .img)
        messages = try container.decode(Array<Messages>.self, forKey: .messages)
    }
}

struct Chats: Codable {
    var Chats: [Chat] = Array();
}
