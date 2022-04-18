//
//  Request.swift
//  Drip
//
//  Created by mikh.popov on 09.04.2022.
//

import Foundation

struct Response<T: Codable>: Codable {
    var status: Int
    var body: T
    
    enum CodingKeys: String, CodingKey {
      case status
      case body
    }
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(status, forKey: .status)
      try container.encode(body, forKey: .body)
    }
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      status = try container.decode(Int.self, forKey: .status)
      body = try container.decode(T.self, forKey: .body)
    }
}
