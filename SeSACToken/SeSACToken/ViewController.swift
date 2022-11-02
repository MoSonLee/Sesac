//
//  ViewController.swift
//  SeSACToken
//
//  Created by 이승후 on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.login()
        api.signup()
        api.profile()
    }
}
