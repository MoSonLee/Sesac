//
//  kakaoAPIManager.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON
// Alamofire + SwiftyJSon
// 검색 키워드
// 인증키
class KaKaoAPIManager {
    static let shared = KaKaoAPIManager()
    private init() {}
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        
        // Alamofire -> URLSession Framework -> 비동기로 request
        // 우리가 비동기로 바꿔주지 않아도 AF 사용시 자동으로 비동기로 바꾸어줌
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
