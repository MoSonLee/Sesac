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
        let signupButtonTapped: Signal<Void>
    }
    
    struct Output {
        let showSignUpVC: Signal<Void>
    }
    
    private let disposeBag = DisposeBag()
    private let showSignUpVCRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        
        input.signupButtonTapped
            .withUnretained(self)
            .emit(onNext: { (vc, _) in
                vc.showSignUpVCRelay.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(showSignUpVC: showSignUpVCRelay.asSignal())
    }
    
}
