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

        Analytics.logEvent("testEvent", parameters: [
          "name": "고래밥",
          "full_text": "안녕하세요",
        ])
        
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
    }
}
