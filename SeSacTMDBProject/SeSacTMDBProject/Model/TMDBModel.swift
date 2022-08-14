//
//  TMDBModel.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/03.
//

import Foundation

struct TMDBModel {
    let movieID: Int
    let movieReleaseDate: String
    let movieTitle: String
    let movievoteAVG: Double
    let movieImageURL: String
    let movieBackdropURL: String
    let movieDescription: String
}

struct TMDBCastModel: Decodable {
    let cast: [Cast]
    
    enum Codingkeys: String, CodingKey {
        case cast
    }
}

struct Cast: Decodable {
    let originalName: String?
    let charcterName: String?
    let profileImageURL: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.originalName = try container.decode(String.self, forKey: .originalName)
        self.charcterName = try container.decode(String.self, forKey: .charcterName)
        self.profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
    }
    
    enum Codingkeys: String, CodingKey {
        case originalName = "original_name"
        case charcterName = "character"
        case profileImageURL = "profile_path"
    }
}

struct GenreModel {
    let genreName: String
}

struct sendDataModel {
    var movieTitleData: String?
    var moviePosterImageData: String?
    var movieBackgroundImageData: String?
    var descriptionData: String?
    var idData: Int?
}
