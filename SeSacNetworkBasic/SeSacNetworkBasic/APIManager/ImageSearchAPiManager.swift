//
//  ImageSearchAPiManager.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    typealias completionHandler = (Int, [String]) -> Void
    private init() {}
    
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)" // 왜 query에 한국어를 넣으면 안 될까?
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SecretID]
        
        AF.request(url, method: .get ,headers: header).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let totalCount = json["total"].intValue
                let list = json["items"].arrayValue.map { $0["link"].stringValue }
                completionHandler(totalCount, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
