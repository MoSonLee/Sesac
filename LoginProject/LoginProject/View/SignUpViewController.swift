//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import UIKit

import RxSwift
import SnapKit

final class SignUpViewController: UIViewController {
    
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
        setViewLayout()
    }
    
    private func setViewComponents() {
        view.backgroundColor = .black
        
        nameTextField.backgroundColor = .systemGray2
        emailTextField.backgroundColor = .systemGray2
        passwordTextField.backgroundColor = .systemGray2
        
        nameTextField.placeholder = "Enter a Name"
        emailTextField.placeholder = "Enter a Email"
        passwordTextField.placeholder = "Enter a Password"
        
        [nameTextField, emailTextField, passwordTextField].forEach {
            view.addSubview($0)
        }
    }
    
    private func setViewLayout() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).multipliedBy(2)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
}
