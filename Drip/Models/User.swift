//
//  User.swift
//  Drip
//
//  Created by mikh.popov on 03.04.2022.
//

import Foundation

struct User: Codable {
    let id: UInt64
    var email: String
    var password: String
    var gender: String
    var Prefer: String
    var FromAge: String
    var ToAge: String
    var Date: String
    var Age: String
    var Description: String
    var Imgs: Array<String>
    var Tags: Array<String>?
    var ReportStatus: String?
    var Payment: Bool?
}
