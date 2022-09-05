//
//  UR-Session+Extension.swift
//  Sesac2Week9
//
//  Created by 이승후 on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endPoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint , completionHandler: completionHandler)
        task.resume()
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpont: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.customDataTask(endpont) { data, response, error in
            guard error == nil else {
                print("Failed Request")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No Data Returned")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable Response")
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failed Response")
                completion(nil, .failedRequest)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch {
                print(error)
                completion(nil, .invalidData)
            }
        }
    }
}
