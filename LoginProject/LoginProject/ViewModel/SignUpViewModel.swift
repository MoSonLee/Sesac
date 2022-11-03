//
//  SignUpViewModel.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class SignUpViewModel {
    
    struct Input {
        let completeButtonTapped: Signal<(String, String, String)>
    }
    
    struct Output {
        let showToast: Signal<String>
        let dismiss: Signal<Void>
    }
    
    private let showToastRelay = PublishRelay<String>()
    private let popVCRelay = PublishRelay<Void>()
    private let disoiseBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.completeButtonTapped
            .emit(onNext: { [weak self] user in
                if user.0.isEmpty || user.1.isEmpty || user.2.isEmpty {
                    self?.showToastRelay.accept("please write all information")
                } else if user.2.count < 8 {
                    self?.showToastRelay.accept("please enter at least eight letters in password")
                } else {
                    self?.signup(userName: user.0, email: user.1, password: user.2)
                }
            })
            .disposed(by: disoiseBag)
        
        return Output(
            showToast: showToastRelay.asSignal(),
            dismiss: popVCRelay.asSignal()
        )
    }
}

extension SignUpViewModel {
    //수정 예정
    func signup(userName: String, email: String, password: String) {
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { [weak self] response in
            
            switch response.response?.statusCode {
            case 200:
                self?.popVCRelay.accept(())
                self?.showToastRelay.accept("Signup Success")
                
            case 405:
                self?.showToastRelay.accept("email already taken")
                
            case 500:
                self?.showToastRelay.accept("paramter is empty")
                
            default:
                self?.showToastRelay.accept("error occured, please try again")
            }
        }
    }
}
