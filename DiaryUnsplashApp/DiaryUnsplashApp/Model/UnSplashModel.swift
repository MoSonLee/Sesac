//
//  UnSplashModel.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import Foundation

struct Response: Decodable {
    var total: Int
    let results: [Results]
}

struct Results: Decodable {
    var description: String?
    var urls: URLs?
}

struct URLs: Codable {
    var regular: String?
}
