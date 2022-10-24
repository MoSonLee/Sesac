//
//  RandomPhoto.swift
//  SeSAC_16_Assignment
//
//  Created by 이승후 on 2022/10/24.
//

import Foundation

struct RandomPhoto: Codable, Hashable {
    let urls: Urls
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case urls, likes
    }
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
