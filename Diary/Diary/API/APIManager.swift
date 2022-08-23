//
//  APIManager.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import Foundation
import Alamofire

final class APIManager {
    static let shared = APIManager()
    private init() {}
    typealias completionHandler = ([Result]) -> Void
    var list: [Result] = []
    
    func requestResults(query: String, completionHandler: @escaping completionHandler) {
        let url = "\(APIKEY.UnSplashAPI)\(query)\(APIKEY.UnSplashAccessKeyEndPoint)"
        AF.request(url, method: .get, encoding: URLEncoding.default).validate().responseDecodable(of: Response.self) { response in
            switch response.result {
                
            case .success(let model):
                self.list = model.results
                completionHandler(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

