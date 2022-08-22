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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver), name: NSNotification.Name("saveButtonNotification"), object: nil)
    }
    
    @objc func saveButtonNotificationObserver(notification: NSNotification) {
       if let name = notification.userInfo?["name"] as? String {
            print(name)
           self.nameButton.setTitle(name, for: .normal)
        }
    }
    
    @objc func nameButtonClicked() {
        NotificationCenter.default.post(name: .saveButton, object: nil, userInfo: ["name\(Int.random(in: 1...100))": 123456])
        
        let vc = ProfileViewController()
        vc.saveButtonActionHandler = { value in
            self.nameButton.setTitle(value, for: .normal)
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

extension NSNotification.Name {
    static let saveButton = NSNotification.Name("saveButtonNotification")
}
