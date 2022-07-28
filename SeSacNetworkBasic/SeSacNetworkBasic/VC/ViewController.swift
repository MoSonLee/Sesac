//
//  ViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocl {
    
    static let identifier: String = "ViewController"
    
    var navigationTitleString: String = "대장님의 다마고치"
    
    var backgroundColor: UIColor = .blue
    
    
    func configureView() {
        title = navigationTitleString
        view.backgroundColor = backgroundColor
        backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

