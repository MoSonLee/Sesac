//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import UIKit

import RxSwift
import SnapKit
import Toast

final class SignUpViewController: UIViewController {

    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let completeButton = UIButton()
    
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var input = SignUpViewModel.Input(
        completeButtonTapped: completeButton.rx.tap
            .withLatestFrom(
                Observable.combineLatest(
                    nameTextField.rx.text.orEmpty,
                    emailTextField.rx.text.orEmpty,
                    passwordTextField.rx.text.orEmpty
                ) {($0, $1, $2)}
            )
            .asSignal(onErrorJustReturn: ("", "", ""))
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
        completeButton.backgroundColor = .systemYellow
        
        nameTextField.placeholder = "Enter a Name"
        emailTextField.placeholder = "Enter a Email"
        passwordTextField.placeholder = "Enter a Password"
        completeButton.setTitle("complete", for: .normal)
        
        [nameTextField, emailTextField, passwordTextField, completeButton].forEach {
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
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
    
    private func bind() {
        output.dismiss
            .emit(onNext: { [weak self] text in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        output.showToast
            .emit(onNext: { text in
                if let topVC = self.view.window?.topViewController() {
                    topVC.view.makeToast(text)
                }
            })
            .disposed(by: disposeBag)
    }
}
