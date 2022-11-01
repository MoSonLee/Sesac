//
//  ValidationViewModel.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/27.
//

import Foundation

import RxCocoa
import RxSwift

final class ValidationViewModel {
    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요!")
    
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let valid = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
}
