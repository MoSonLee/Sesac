//
//  EditNoteViewModel.swift
//  RXStudy
//
//  Created by 이승후 on 2022/09/09.
//

import Foundation

import RxSwift
import RxRelay
import RxCocoa

final class EditNoteViewModel {
    
    typealias Note = (String, String)
    
    struct Input {
        //여러번 눌릴 수 있으므로 signal
        //주로 튜플말고 모델을 만들어서 보내줌
        // realm에 모델을 추가해주면 됨
        let completeBarButtonTap: Signal<Note>
        let saveAlertConfirmActionTap: Signal<Void>
    }
    
    struct Output {
        let showAlert: Signal<String>
        let dismiss: Signal<Void>
    }
    
    let disoiseBag = DisposeBag()
    
    //메세지에 어떤 알럿인지 알려줘야하기 때문에 string
    private let showAlertRelay = PublishRelay<String>()
    private let dismissVCRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        //assignal 해줄 필요없음 이미 signal로 받아와서
        input.completeBarButtonTap
            .emit(onNext: { [weak self] note in
                let title = note.0
                let content = note.1
                if content.count == 0 || title.count == 0 {
                    self?.showAlertRelay.accept("글을 작성해주세요.")
                    
                } else if content.count < 5 {
                    self?.showAlertRelay.accept("5글자 이상 써주세요")
                    
                } else {
                    //렘에저장
                    self?.saveRealm(title: note.0, content: note.1)
                }
            })
            .disposed(by: disoiseBag)
        
        input.saveAlertConfirmActionTap
            .emit(onNext: { [weak self] _ in
                self?.dismissVCRelay.accept(())
            })
            .disposed(by: disoiseBag)
        
        return Output(
            //relay랑 연결해야됨
            showAlert: showAlertRelay.asSignal(),
            dismiss: dismissVCRelay.asSignal()
        )
    }
}

extension EditNoteViewModel {
    // 렘에 저장
    private func saveRealm(title: String, content: String) {
        //완료인 경우
        self.showAlertRelay.accept("저장되었습니다")
        //실패인 경우
//        self.showAlertRelay.accept("저장에 실패했습니다. 다시 시도해주세요.")
//        self.dismissVCRelay.accept(())
    }
}

// behaviorRelay의 짝은 Driver
// PublishRelay의 짝은 Signal
// Driver는 보통 초기값으 가진채로 바인딩할려고할 때 씀( tableview, collectionView)
// Driver도 stream 공유가 됨
