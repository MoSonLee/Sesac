//
//  APIManager.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    var list: [TMDBModel] = []
    var castingList: [TMDBCastModel] = []
    
    typealias completionHandler = (Int, [TMDBModel]) -> Void
    typealias castCompletionHandler = (Int, [TMDBCastModel]) -> Void
    typealias videoCompletionHandler = (Int, String) -> Void
    
    func requestTMDB(movieNumber: Int, completionHandler: @escaping completionHandler) {
        let url = APIKEY.TMDBURLWithMyKey
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                for i in self.list.count ..< movieNumber {
                    let index = json["results"][i]
                    let movieID = index["id"].intValue
                    let movieReleaseDate = index["release_date"].stringValue
                    let movieTitle = index["title"].stringValue
                    let movieDescription = index["overview"].stringValue
                    let movieURL = index["poster_path"].stringValue
                    let movieAvg = index["vote_average"].doubleValue
                    let movieBackdrop = index["backdrop_path"].stringValue
                    let data = TMDBModel(movieID: movieID, movieReleaseDate: movieReleaseDate , movieTitle: movieTitle, movievoteAVG: movieAvg, movieImageURL: movieURL, movieBackdropURL: movieBackdrop, movieDescription: movieDescription)
                    self.list.append(data)
                }
                completionHandler(movieNumber, self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
     func requestCasting(data: Int, castCompletionHandler: @escaping castCompletionHandler) {
        let url = "\(APIKEY.TMDBCastingURL)\(data)\(EndPoint.TMDBCastingEndPoint)"
         
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for cast in json["cast"].arrayValue {
                    let originalName = cast["name"].stringValue
                    let charcterName = cast["character"].stringValue
                    let profileImageURL = cast["profile_path"].stringValue
                    let data = TMDBCastModel(originalName: originalName, charcterName: charcterName, profileImageURL: profileImageURL)
                    self.castingList.append(data)
                }
                castCompletionHandler(data, self.castingList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTMDBVideo(data: Int, urlStringData: String, videoCompletionHandler: @escaping videoCompletionHandler) {
       let url = "\(APIKEY.TMDBCastingURL)\(data)\(VideoEndPoint.TMDBVideoEndPoint)"
       AF.request(url, method: .get).validate().responseData { response in
           switch response.result {
           case .success(let value):
               let json = JSON(value)
               let videoURL = json["results"][0]["key"].stringValue
               let url = "\(YoutubeStartPont.YoutubeFirstPont+videoURL)"
               videoCompletionHandler(data, url)
               
           case .failure(let error):
               print(error)
           }
       }
   }
}
