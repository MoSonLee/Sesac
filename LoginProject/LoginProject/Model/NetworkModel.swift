//
//  NetworkModel.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import Foundation

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

enum SeSACError: Int, Error {
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501

}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "token has been expired"
        case .takenEmail:
            return "already Signup. Please try login"
        case .emptyParameters:
            return "파라미터가 없습니다"
        }
    }
}
