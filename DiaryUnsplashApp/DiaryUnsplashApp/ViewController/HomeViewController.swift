//
//  HomeViewController.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var homeView = HomeView()
    
    override func loadView() {
        super.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
