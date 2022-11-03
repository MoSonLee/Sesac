//
//  HomeViewModel.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import Foundation

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
    
    private let disposeBag = DisposeBag()
    
    private let showToastRelay = PublishRelay<String>()
    private let showLoginVCRelay = PublishRelay<Void>()
    private let showSignUpVCRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        
        input.loginButtonTapped
            .withUnretained(self)
            .emit(onNext: { userInfo in
               
            })
            .disposed(by: disposeBag)
        
        input.signupButtonTapped
            .withUnretained(self)
            .emit(onNext: { (vc, _) in
                vc.showSignUpVCRelay.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(
            showToast: showToastRelay.asSignal(),
            showProfileVC: showLoginVCRelay.asSignal(),
            showSignUpVC: showSignUpVCRelay.asSignal()
        )
    }
}

