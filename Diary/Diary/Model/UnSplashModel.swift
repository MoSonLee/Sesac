//
//  UnSplashModel.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import Foundation

struct Response: Decodable {
    let total: Int
    let results: [Result]
}

struct Result: Decodable {
    let description: String?
    let urls: URLs?
}

struct URLs: Codable {
    let raw: String?
}
