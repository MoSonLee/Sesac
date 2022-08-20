//
//  UnSplashModel.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import Foundation

struct APIResponse: Decodable {
    let results: [Results]
    
    enum Codingkeys: String, CodingKey {
        case results
    }
}

struct Results: Decodable {
    var urls: [URLs]
}

struct URLs: Codable {
    var raw: String
}
