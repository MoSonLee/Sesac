//
//  APIManager.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON
import SwiftUI
import Kingfisher

class APIManager {
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    static let shared = APIManager()
    private init() {}
    
    let tvList = [
        ("Weekend at Bernie's", 8491),
        ("The Ewok Adventure", 1884),
        ("Enemy Mine", 11864),
        ("Asterix vs. Caesar", 8868),
        ("The Cutting Edge", 16562)
    ]
    
    var list: [TMDBModel] = []
    var castingList: [TMDBCastModel] = []
    var weatherList: [WeatherModel] = []
    var resultImageView: UIImageView?
    
    typealias completionHandler = (Int, [TMDBModel]) -> Void
    typealias castCompletionHandler = (Int, [TMDBCastModel]) -> Void
    typealias videoCompletionHandler = (Int, String) -> Void
    typealias weatherCompletionHandler = (String, String, Double, Double, Double, Double, Int) -> Void
    
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
        let url = "\(APIKEY.TMDBFirstMovieURL)\(data)\(EndPoint.TMDBCastingEndPoint)"
        
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
        let url = "\(APIKEY.TMDBFirstMovieURL)\(data)\(VideoEndPoint.TMDBVideoEndPoint)"
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
    
    func requestTMDBRecommandList(movieId: Int, completionHandler: @escaping ([String]) -> () ) {
        let url = "\(APIKEY.TMDBFirstMovieURL)\(movieId)\(TMDBRecommand.key)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let imagePathValue = json["results"].arrayValue.map {
                    $0["poster_path"].stringValue
                }
                completionHandler(imagePathValue)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(videoCompletionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        APIManager.shared.requestTMDBRecommandList(movieId: tvList[0].1) {
            value in
            posterList.append(value)
            
            APIManager.shared.requestTMDBRecommandList(movieId: self.tvList[1].1) { value in
                posterList.append(value)
                
                APIManager.shared.requestTMDBRecommandList(movieId: self.tvList[2].1){ value in
                    posterList.append(value)
                    
                    APIManager.shared.requestTMDBRecommandList(movieId: self.tvList[3].1){ value in
                        posterList.append(value)
                        
                        APIManager.shared.requestTMDBRecommandList(movieId: self.tvList[4].1){ value in
                            posterList.append(value)
                            videoCompletionHandler(posterList)
                        }
                    }
                }
            }
        }
        dump(posterList)
    }
    
    func requestWeather(location: String, weatherHandler: @escaping weatherCompletionHandler ) {
        let url = "\(WeatherAPIKEY.weatherFirstPoint)\(location)\(WeatherAPIKEY.myKey)"
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let weatherImage = json["weather"][0]["icon"].stringValue
                let locationName = json["name"].stringValue
                let temp = json["main"]["temp"].doubleValue
                let windSpeed = json["wind"]["speed"].doubleValue
                let humidity = json["main"]["humidity"].intValue
                let longtitude = json["coord"]["lon"].doubleValue
                let latitude = json["coord"]["lat"].doubleValue
                weatherHandler(weatherImage, locationName, temp, windSpeed,longtitude, latitude, humidity)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
