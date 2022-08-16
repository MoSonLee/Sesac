//
//  APIManager.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/06.
//

import Foundation
import CoreLocation

import Alamofire
import SwiftyJSON

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
    var castingList: [Cast] = []
    var weatherList: [WeatherModel] = []
    
    typealias completionHandler = ([TMDBModel]?, Int?) -> Void
    typealias castCompletionHandler = (Int, [Cast]) -> Void
    typealias videoCompletionHandler = (Int, String) -> Void
    typealias weatherCompletionHandler = (String, String, Double, Double, Double, Double, Int) -> Void
    
    var page = 1
    
    func requestTMDB(completionHandler: @escaping completionHandler) {
        let url = APIKEY.TMDBURLWithMyKey
        
        AF.request(url, method: .get).validate().responseData { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in self.list.count ..< self.page * 10 {
                    if json["results"].count <= self.list.count {
                        completionHandler(nil, 0 )
                        return
                    }
                    let index = json["results"][i]
                    if json["results"].count <= self.list.count {
                        return
                    }
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
                self.page += 1
                completionHandler(self.list, nil)
                
            case .failure( _):
                self.page = 1
                completionHandler(nil, 0)
            }
        }
    }
    
    func requestCasting(id: Int, castCompletionHandler: @escaping castCompletionHandler) {
        let url = "\(APIKEY.TMDBFirstMovieURL)\(id)\(EndPoint.TMDBCastingEndPoint)"
        AF.request(url, method: .get, encoding: URLEncoding.default).validate().responseDecodable(of: TMDBCastModel.self) { response in
            switch response.result {
            case .success(let model):
                self.castingList = model.cast
                castCompletionHandler(id, self.castingList)
                
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
                let url = YoutubeStartPont.YoutubeFirstPont+videoURL
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
    
    func requestWeather(latitude: Double, longtitude: Double, weatherHandler: @escaping weatherCompletionHandler ) {
        let url = "\(WeatherAPIKEY.weatherFirstPoint)lat=\(latitude)&lon=\(longtitude)\(WeatherAPIKEY.myKey)"
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
