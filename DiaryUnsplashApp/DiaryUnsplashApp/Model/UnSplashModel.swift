//
//  UnSplashModel.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import Foundation

struct Response: Decodable {
    let total: Int
    let results: [Results]
}

struct Results: Decodable {
    let description: String?
    let urls: URLs?
}

struct URLs: Codable {
    let raw: String?
}
