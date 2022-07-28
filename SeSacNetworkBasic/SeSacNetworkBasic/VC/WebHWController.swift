//
//  WebHW.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/28.
//

import UIKit
import WebKit

class WebHWController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var reloadBarButton: UIBarButtonItem!
    @IBOutlet weak var forwardBarButton: UIBarButtonItem!
    
    var destinationURL: String = "https://www.daum.net"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonImage()
        searchBar.delegate = self
        openWebPage(url: destinationURL)
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backBarButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadBarButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func forwardBarButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func setButtonImage() {
        cancelBarButton.image = UIImage(systemName: "xmark")
        backBarButton.image = UIImage(systemName: "arrow.left")
        reloadBarButton.image = UIImage(systemName: "arrow.clockwise")
        forwardBarButton.image = UIImage(systemName: "arrow.right")
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebHWController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
