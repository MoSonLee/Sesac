//
//  EndPoint.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/08.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    // enum에서 저장 프로퍼티를 못쓰는 이유? 연산프로퍼티는 쓸 수 있음
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}
