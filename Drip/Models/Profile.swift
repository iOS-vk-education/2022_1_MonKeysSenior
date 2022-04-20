struct Profile: Codable {
    let id: String
    var name: String
    var age: String
    var description: String
    var tags: [String]
    var imgsURL: [String]
}
