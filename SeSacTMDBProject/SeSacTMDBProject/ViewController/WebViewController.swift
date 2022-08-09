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
import JGProgressHUD

final class WebViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    private var destinationURL: String?
    var movieIDData: Int?
    private lazy var hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
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
        APIManager.shared.requestTMDBVideo(data: movieIDData!, urlStringData: destinationURL ?? "https://www.youtube.com") { movieIDData, url in
            self.hud.show(in: self.view, animated: true)
            self.hud.textLabel.text = "Loading"
            self.movieIDData = movieIDData
            self.destinationURL = url
            
            DispatchQueue.main.async {
                self.openWebPage(url:  self.destinationURL!)
                self.hud.dismiss(animated: true)
            }
        }
    }
    
    @objc
    private func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style:.plain, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
}
