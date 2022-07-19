//
//  MovieModel.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

enum Movie: Int, CaseIterable {
    case movie1, movie2, movie3, movie4
    
    var movieSection: Int {
        switch self {
        case .movie1:
            return 1
        case .movie2:
            return 1
        case .movie3:
            return 1
        case .movie4:
            return 1
        }
    }
    var movieImage: UIImage? {
        switch self {
        case .movie1:
            return UIImage(named: "harrypotter0")
        case .movie2:
            return UIImage(named: "harrypotter1")
        case .movie3:
            return UIImage(named: "harrypotter2")
        case .movie4:
            return UIImage(named: "harrypotter3")
        }
    }
    
    var movieTitle: String {
        switch self {
        case .movie1:
            return "해리포터1"
        case .movie2:
            return "해리포터2"
        case .movie3:
            return "해리포터3"
        case .movie4:
            return "해리포터4"
        }
    }
    
    var movieDate: String {
        switch self {
        case .movie1:
            return "2022.01.01"
        case .movie2:
            return "2022.01.02"
        case .movie3:
            return "2022.01.03"
        case .movie4:
            return "2022.01.04"
        }
    }
    
    var movieDescription: String {
        switch self {
        case .movie1:
            return "대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌"
        case .movie2:
            return "대박 완전 열심히 해리랑 볼박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌"
        case .movie3:
            return "대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌"
        case .movie4:
            return "대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌대박 완전 열심히 해리랑 볼드모트랑 어쩌구저쩌궁저쩌"
        }
    }
    
}
