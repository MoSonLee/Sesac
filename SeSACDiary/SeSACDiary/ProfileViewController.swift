//
//  ProfileViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/18.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.tintColor = .black
        view.backgroundColor = .black
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력하세요"
        view.backgroundColor = .brown
        view.textColor = .black
        return view
    }()
    
    var saveButtonActionHandler: ((String) -> ())?
    
    func configure() {
        [saveButton, nameTextField].forEach { view.addSubview($0)}
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(50)
            $0.top.equalTo(50)
            $0.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalTo(view)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .systemIndigo
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SaveButtonNotificationObserver), name: NSNotification.Name("TEST"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("TEST"), object: nil)
    }
    
    @objc func SaveButtonNotificationObserver(notification: NSNotification) {
        print(#function)
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameTextField.text = name
        }
    }
    
    @objc func saveButtonClicked() {
        
        //2. Notification
        NotificationCenter.default.post(name: NSNotification.Name("saveButtonNotification"), object: nil, userInfo: ["name": nameTextField.text!, "value": 123456])
        
        // 값 전달 기능 실행
        //        saveButtonActionHandler?(nameTextField.text!)
        //화면 dismiss
        dismiss(animated: true)
    }
}
