//
//  SecondViewController.swift
//  Delivery
//
//  Created by 이승후 on 2022/07/05.
//

import UIKit

final class FirstViewController: UIViewController {

    //아웃렛 변수
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!

    //viewController 생명주기 종류 중 하나
    //사용자에게 화면이 보이기 직전에 실행이 된다.
    // option command < >
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerImageView.image = UIImage(named: "food\(Int.random(in: 1...5))")
        bannerImageView.layer.cornerRadius = 30
        bannerImageView.layer.borderWidth = 5
        bannerImageView.layer.borderColor = UIColor.blue.cgColor

        movieTitleLabel.text = "맛있는 마카롱"
        movieTitleLabel.backgroundColor = UIColor.yellow
        movieTitleLabel.textColor = UIColor.red
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    @IBAction private func resultButtonClicked(_ sender: UIButton) {
        bannerImageView.image = UIImage(named: "food\(Int.random(in: 1...5))")
    }
}
