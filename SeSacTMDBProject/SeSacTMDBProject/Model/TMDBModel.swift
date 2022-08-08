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

struct TMDBCastModel {
    let originalName: String?
    let charcterName: String?
    let profileImageURL: String
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
