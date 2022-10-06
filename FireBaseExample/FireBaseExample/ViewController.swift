//
//  ViewController.swift
//  FireBaseExample
//
//  Created by 이승후 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("ReJack", parameters: [
          "name": "고래밥" as NSObject,
          "full_text": "안녕하세요" as NSObject,
        ])
        
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
        
    }


}

