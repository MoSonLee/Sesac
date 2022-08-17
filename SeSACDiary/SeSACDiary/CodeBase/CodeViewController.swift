//
//  CodeViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/17.
//

import UIKit

/*
 공통
 1. 뷰객체 프로퍼티 선언. 클래스의 인스턴스를 생성
 2.명시적으로 루트뷰에 추가
 3. 크기와 위치 및 속성 정의
 -> frame 기반 한계
 -> autoreszingMask, autolayout 등장!
 -> NSLayoutConstraints
 */

final class CodeViewController: UIViewController {
    //1. 뷰객체 프로퍼티 선언. 클래스의 인스턴스를 생성
    private lazy var emailTextField = UITextField()
    private lazy var passwordTextField = UITextField()
    private lazy var signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2. 명시적으로 RootView에 추가
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signButton)
        view.backgroundColor = .systemMint
        
        //3. 크기와 위치 및 속성 정의 -> Frame 기반
        emailTextField.frame = CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 50)
        emailTextField.borderStyle = .line
        emailTextField.backgroundColor = .lightGray
        passwordTextField.backgroundColor = .red
        
        //3. -> NSLayoutConstraints 기반
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 150)
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        
        view.addConstraints([top, leading, trailing, height])
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .red
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
