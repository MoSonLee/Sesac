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
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.urls = try container.decode(URLs.self, forKey: .urls)
//    }
//
//    enum Codingkeys: String, CodingKey {
//        case description = "description"
//        case urls = "urls"
//    }
}

struct URLs: Codable {
    let raw: String?
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//        self.raw = try container.decode(String.self, forKey: .raw)
//    }
//
//    enum Codingkeys: String, CodingKey {
//        case raw = "raw"
//    }
}
