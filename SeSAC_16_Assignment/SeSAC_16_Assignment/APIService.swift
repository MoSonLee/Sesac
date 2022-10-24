//
//  APIService.swift
//  SeSAC_16_Assignment
//
//  Created by 이승후 on 2022/10/24.
//

import Foundation

import Alamofire

class APIService {
    static func randomPhoto(completion: @escaping (RandomPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.randomURL)\(APIKey.authorization)"
        
        AF.request(url, method: .get).responseDecodable(of: RandomPhoto.self) { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
        }
    }
    
    private init() {
        
    }
}
