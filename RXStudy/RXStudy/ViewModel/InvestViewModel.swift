//
//  InvestViewModel.swift
//  RXStudy
//
//  Created by 이승후 on 2022/08/21.
//

import Foundation

import Moya
import RxSwift
import RxRelay
import RxCocoa

enum FintServerError: Int, Error {
    
    case duplicatedError = 201
    case inValidURL = 404
    case unregisterUser = 406
    case internalServerError = 500
    case internalClientError = 501
    case unknown
    
    var description: String { self.errorDescription }
}

extension FintServerError {
    
    var errorDescription: String {
        switch self {
        case .duplicatedError: return "201:DUPLICATE_ERROR"
        case .inValidURL: return "404:INVALID_URL_ERROR"
        case .unregisterUser: return "406:UNREGISTER_USER_ERROR"
        case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
        case .internalClientError: return "501:INTERNAL_CLIENT_ERROR"
        default: return "UN_KNOWN_ERROR"
        }
    }
}

final class InvestViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let accounts: Driver<[Account]>
        let hashString: Signal<String>
        let titleText: Signal<String>
        let showAlert: Signal<String>
    }
    
    let showAlertRelay = PublishRelay<String>()
    let accountRelay = BehaviorRelay<[Account]>(value: [])
    let hashRelay = PublishRelay<String>()
    let titleRelay = PublishRelay<String>()
    let disoiseBag = DisposeBag()
    let provider: MoyaProvider<FintTarget>
    
    init() { provider = MoyaProvider<FintTarget>() }
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.requestAccount(hash: "#00BADA")
            })
            .disposed(by: disoiseBag)
        return Output(accounts: accountRelay.asDriver(),
                      hashString: hashRelay.asSignal(),
                      titleText: titleRelay.asSignal(),
                      showAlert: showAlertRelay.asSignal()
        )
    }
}

extension InvestViewModel {
    
    func requestAccount(hash: String
    ) {
        let parameters = ["hash": hash]
        provider.request(.accounts(parameters: parameters)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let data = try! JSONDecoder().decode(UserAccounts.self, from: response.data)
                self.accountRelay.accept(data.accounts)
                self.hashRelay.accept(data.hash)
                self.titleRelay.accept(data.userName)
                
            case .failure(let error):
                let serverError = FintServerError(rawValue: error.response?.statusCode ?? -1) ?? .unknown
                switch serverError {
                case .duplicatedError:
                    self.showAlertRelay.accept("중복된 이름입니다.")
                default:
                    print("A")
                }
            }
        }
    }
}
