//
//  ProfileViewModel.swift
//  LoginProject
//
//  Created by 이승후 on 2022/11/04.
//

import Foundation

import Alamofire
import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let logoutButtonTapped: Signal<(Void)>
    }
    
    struct Output {
        let showToast: Signal<String>
        let dismiss: Signal<Void>
        let profile: Driver<User>
    }
    
    private let getProfileRelay = BehaviorRelay<User>(value: User(photo: "", email: "", username: ""))
    private let deleteTokenRelay = PublishRelay<Void>()
    private let popVCRelay = PublishRelay<Void>()
    private let showToastRelay = PublishRelay<String>()
    private let disoiseBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .subscribe(onNext: { [weak self] _ in
                self?.profile()
            })
            .disposed(by: disoiseBag)
        
        input.logoutButtonTapped
            .emit(onNext: { [weak self] _ in
                UserDefaults.standard.removeObject(forKey: "token")
                self?.popVCRelay.accept(())
                self?.showToastRelay.accept("logout success")
            })
            .disposed(by: disoiseBag)
        
        return Output(
            showToast: showToastRelay.asSignal(),
            dismiss: popVCRelay.asSignal(),
            profile: getProfileRelay.asDriver()
        )
    }
}

extension ProfileViewModel {
    func profile() {
        let api = SeSACAPI.profile
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    self?.getProfileRelay.accept(data.user)
                    
                case .failure(_):
                    self?.showToastRelay.accept("Error occured")
                }
            }
    }
}
