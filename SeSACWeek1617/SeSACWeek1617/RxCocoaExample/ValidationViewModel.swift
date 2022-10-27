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
}
