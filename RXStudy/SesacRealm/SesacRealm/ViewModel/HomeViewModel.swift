//
//  HomeViewModel.swift
//  SesacRealm
//
//  Created by 이승후 on 2022/08/22.
//

import Foundation

import RxCocoa
import RxSwift
import RxRelay

final class HomeViewModel {
    
    let tableCellArray: [TableModel] = [
        TableModel(checkButtonString: "checkmark.square", labelText: "아이폰 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "맥북 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이패드 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이맥 구매하기", starButtonString: "star")
    ]
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }

    struct Output {
        let tableViewModel: Driver<[TableModel]>
    }
    
    private lazy var tableRelay = BehaviorRelay<[TableModel]>(value: tableCellArray)
    let disoiseBag = DisposeBag()
    let tableData: [TableModel] = []
    
    func transform(input: Input) -> Output {
        input.viewDidLoad
            .subscribe(onNext: { [weak self] _ in
        
            })
            .disposed(by: disoiseBag)
        return Output(tableViewModel: tableRelay.asDriver())
    }
}

extension HomeViewModel {

}


