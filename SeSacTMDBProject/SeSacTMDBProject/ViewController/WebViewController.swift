//
//  WebViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/05.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON

final class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    private var destinationURL: String?
    var movieIDData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTMDBVideo(movieIDData!)
    }
    
    private func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func requestTMDBVideo(_ data: Int) {
        let url = "\(APIKEY.TMDBCastingURL)\(data)\(VideoEndPoint.TMDBVideoEndPoint)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let videoURL = json["results"][0]["key"].stringValue
                self.destinationURL = "\(YoutubeStartPont.YoutubeFirstPont+videoURL)"
                self.openWebPage(url: self.destinationURL!)
                self.view.reloadInputViews()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
