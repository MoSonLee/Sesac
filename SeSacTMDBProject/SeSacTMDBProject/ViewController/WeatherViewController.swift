//
//  WeatherViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/13.
//

import UIKit

import Kingfisher

final class WeatherViewController: UIViewController {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var helloLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    
    var weatherImageString: String = ""
    var locationNameString: String = ""
    var temp: Double = 0.0
    var windSpeed: Double = 0.0
    var humidity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewData()
        setImage(weatherImageString)
    }
    
    private func setImage(_ imageID: String) {
        let url = URL(string: "http://openweathermap.org/img/wn/\(imageID)@2x.png")
        weatherImageView.kf.setImage(with: url)
    }
    
    private func setViewData() {
        view.backgroundColor = .systemCyan
        dateLabel.text = String()
        tempLabel.text = "현재 기온은 \(round(temp-273))"
        tempLabel.textAlignment = .center
        tempLabel.backgroundColor = .purple
        humidityLabel.text = "현재 습도는 \(humidity)"
        humidityLabel.textAlignment = .center
        humidityLabel.backgroundColor = .systemPink
        windSpeedLabel.text = "현재 풍속은 \(windSpeed)"
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.backgroundColor = .green
        helloLabel.text = "오늘도 행복한 하루 보내세요"
    }
}
