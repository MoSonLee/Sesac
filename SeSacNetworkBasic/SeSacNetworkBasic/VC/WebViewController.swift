//
//  WebViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        openWebPage(url: destinationURL)
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

extension WebViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
        print("AA")
    }
}
