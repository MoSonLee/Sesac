//
//  HomeViewModel.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class HomeViewModel {
    
    struct Input {
        let loginButtonTapped: Signal<(String, String)>
        let signupButtonTapped: Signal<Void>
    }
    
    struct Output {
        let showToast: Signal<String>
        let showProfileVC: Signal<Void>
        let showSignUpVC: Signal<Void>
    }
    
    private let showToastRelay = PublishRelay<String>()
    private let showProfileVCRelay = PublishRelay<Void>()
    private let showSignUpVCRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.loginButtonTapped
            .emit(onNext: { [weak self] userInfo in
                self?.login(userEmail: userInfo.0, userPassword: userInfo.1)
            })
            .disposed(by: disposeBag)
        
        input.signupButtonTapped
            .emit(onNext: { [weak self] _ in
                self?.showSignUpVCRelay.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(
            showToast: showToastRelay.asSignal(),
            showProfileVC: showProfileVCRelay.asSignal(),
            showSignUpVC: showSignUpVCRelay.asSignal()
        )
    }
}

extension HomeViewModel {
    private func login(userEmail: String, userPassword: String) {
        let api = SeSACAPI.login(email: userEmail, password: userPassword)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) {[weak self] response in
                switch response.result {
                case .success(let data):
                    UserDefaults.standard.set(data.token, forKey: RawString.token.rawValue)
                    self?.showProfileVCRelay.accept(())
                    
                case .failure(_):
                    self?.showToastRelay.accept(RawString.loginFail.rawValue)
                }
            }
    }
}
