//
//  ProfileViewController.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ProfileViewController: UIViewController {
    
    private let emailLabel = UILabel()
    private let nameLabel = UILabel()
    private let tokenLabel = UILabel()
    private let logoutButton = UIButton()
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    private  let viewWillAppearEvent = PublishRelay<Void>()
    
    private lazy var input = ProfileViewModel.Input(
        viewWillAppear: viewWillAppearEvent.asObservable(),
        logoutButtonTapped: logoutButton.rx.tap.asSignal())
    private lazy var output = viewModel.transform(input: input)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearEvent.accept(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
        setViewLayout()
        bind()
    }
    
    private func setViewComponents() {
        view.backgroundColor = .black
        emailLabel.backgroundColor = .systemYellow
        nameLabel.backgroundColor = .systemYellow
        tokenLabel.backgroundColor = .systemYellow
        logoutButton.backgroundColor = .systemBlue
        
        logoutButton.setTitle("LogOut", for: .normal)
        
        [emailLabel, nameLabel, tokenLabel, logoutButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setViewLayout() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).multipliedBy(2)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        tokenLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(tokenLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
    
    private func bind() {
        output.profile
            .drive() { [weak self] profile in
                self?.emailLabel.text = "\(RawString.email.rawValue): \(profile.email)"
                self?.nameLabel.text = "\(RawString.name.rawValue): \(profile.username)"
                self?.tokenLabel.text = "\(RawString.token.rawValue): \(UserDefaults.standard.string(forKey: RawString.token.rawValue) ?? "")"
            }
            .disposed(by: disposeBag)
        
        output.showToast
            .emit(onNext: { [weak self] text in
                if let topVC = self?.view.window?.topViewController() {
                    topVC.view.makeToast(text)
                }
            })
            .disposed(by: disposeBag)
        
        output.dismiss
            .emit(onNext: { [weak self] text in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}
