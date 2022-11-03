//
//  HomeViewController.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class HomeViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    private let signUpButton = UIButton()
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var input = HomeViewModel.Input(
        signupButtonTapped: signUpButton.rx.tap.asSignal()
    )
    
    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
        setViewLayout()
        bind()
    }
    
    private func setViewComponents() {
        view.backgroundColor = .black
        
        nameTextField.backgroundColor = .systemGray2
        emailTextField.backgroundColor = .systemGray2
        passwordTextField.backgroundColor = .systemGray2
        
        loginButton.backgroundColor = .systemYellow
        signUpButton.backgroundColor = .systemBlue
        
        nameTextField.placeholder = "Enter a Name"
        emailTextField.placeholder = "Enter a Email"
        passwordTextField.placeholder = "Enter a Password"
        
        loginButton.setTitle("Login", for: .normal)
        signUpButton.setTitle("SignUp", for: .normal)
        
        [nameTextField, emailTextField, passwordTextField, loginButton, signUpButton].forEach {
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
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
    
    private func bind() {
        output.showSignUpVC
            .withUnretained(self)
            .emit(onNext: { [weak self] _ in
                let vc = SignUpViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
