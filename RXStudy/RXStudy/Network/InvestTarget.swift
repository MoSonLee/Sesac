//
//  InvestTarget.swift
//  RXStudy
//
//  Created by 이승후 on 2022/08/21.
//

import Foundation
import Moya

typealias DictionaryType = [String: Any]

enum FintTarget {
    case accounts(parameters: DictionaryType)
    case detail(parameters: DictionaryType)
    case assets(parameters: DictionaryType)
    case update(parameters: DictionaryType)
}

extension FintTarget: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIConstant.environment.rawValue) else {
            fatalError("fatal error - invalid api url")
        }
        return url
    }

    var path: String {
        switch self {
        case .accounts:
            return "/accounts"
        case .detail:
            return "/detail"
        case .assets:
            return "/assets"
        case .update:
            return "/update"
        }
    }

    var method: Moya.Method {
        switch self {
        case .accounts,
             .detail,
             .assets,
             .update:
            return .post
        }
    }

    var sampleData: Data {
        return stubData(self)
    }

    var task: Task {
        switch self {
        case .accounts(let parameters),
             .detail(let parameters),
             .assets(let parameters),
             .update(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    var validationType: ValidationType {
        return .customCodes([200])
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "x-api-key": "QsGFilqP199uOmOmjtkPq9zaNlQV5r7TJIuNuIE6"
        ]
    }
}
