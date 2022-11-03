//
//  Network.swift
//  SeSACToken
//
//  Created by 이승후 on 2022/11/03.
//

import Foundation

import Alamofire

final class Network {
    static let shared = Network()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let data):
                    completion(.success(data)) // Result 자체를 넘기기
                case .failure(_):
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
}
