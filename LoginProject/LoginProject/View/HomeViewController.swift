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
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let signUpButton = UIButton()
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var input = HomeViewModel.Input(
        loginButtonTapped: loginButton.rx.tap
            .withLatestFrom(
                Observable.combineLatest(
                    emailTextField.rx.text.orEmpty,
                    passwordTextField.rx.text.orEmpty
                ) {($0, $1)}
            )
            .asSignal(onErrorJustReturn: ("", "")),
        
        signupButtonTapped: signUpButton.rx.tap.asSignal())
    private lazy var output = viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
        setViewLayout()
        bind()
    }
    
    private func setViewComponents() {
        view.backgroundColor = .black
        emailTextField.backgroundColor = .systemGray2
        passwordTextField.backgroundColor = .systemGray2
        loginButton.backgroundColor = .systemYellow
        signUpButton.backgroundColor = .systemBlue
        
        emailTextField.placeholder = RawString.enterPassword.rawValue
        passwordTextField.placeholder = RawString.enterPassword.rawValue
        
        loginButton.setTitle(RawString.login.rawValue, for: .normal)
        signUpButton.setTitle(RawString.signUp.rawValue, for: .normal)
        
        [emailTextField, passwordTextField, loginButton, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setViewLayout() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).multipliedBy(2)
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
            .emit(onNext: { [weak self] _ in
                let vc = SignUpViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.showProfileVC
            .emit(onNext: { [weak self] _ in
                let vc = ProfileViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.showToast
            .emit(onNext: { [weak self] text in
                if let topVC = self?.view.window?.topViewController() {
                    topVC.view.makeToast(text)
                }
            })
            .disposed(by: disposeBag)
    }
}
