//
//  ViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit
import MosonLeeFramework

final class ViewController: UIViewController {
    
    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.tintColor = .black
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
    }
    
    @objc func nameButtonClicked() {
        let vc = ProfileViewController()
        vc.saveButtonActionHandler = {
            self.nameButton.setTitle(vc.nameTextField.text, for: .normal)
        }
        present(vc, animated: true)
    }
    
    func configure() {
        view.addSubview(nameButton)
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
    }
}

