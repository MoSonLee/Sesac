//
//  EditNoteViewController.swift
//  RXStudy
//
//  Created by 이승후 on 2022/09/09.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class EditNoteViewController: UIViewController {
    
    private let completeBarButton = UIBarButtonItem()
    
    private let nameTextView = UITextView()
    private let contentTextView = UITextView()
    
    private let viewModel = EditNoteViewModel()
    
    let disposdeBag = DisposeBag()
    
    //vm에서 보내준 note를 받아오기 위해
    private lazy var input = EditNoteViewModel.Input(
        //void인 observable을 방출하는 tap만 온 것임. tap된게 트리거임
        //합친느거에 두가지 종류가 있음 combinelatest, zip
        //fury에선 텍스트, 텍스트, 데이트를 합쳐야한다.
        completeBarButtonTap: completeBarButton.rx.tap
            .withLatestFrom(
                //observable이 옴
                // 인자를 하나씩 맞춰줌
                Observable.combineLatest(
                    nameTextView.rx.text.orEmpty,
                    contentTextView.rx.text.orEmpty
                ) { ($0, $1) }
            )
            .asSignal(onErrorJustReturn: ("", "")),
        
        saveAlertConfirmActionTap: saveAlertConfirmActionRelay.asSignal()
    )
    
    private lazy var output = viewModel.transform(input: input)
    
    private lazy var saveAlertConfirmActionRelay = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setConstraints()
    }
    
    private func bind() {
        output.showAlert
            .emit(onNext: {[weak self] text in
                let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                    self?.saveAlertConfirmActionRelay.accept(())
                }
                alert.addAction(confirmAction)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposdeBag)
        
        output.dismiss
            .emit(onNext: { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposdeBag)
    }
}

//MARK: Private func
extension EditNoteViewController {
    private func setConstraints() {
        
        navigationItem.title = "글 작성하기"
        view.backgroundColor = .white
        
        nameTextView.backgroundColor = .white
        contentTextView.backgroundColor = .systemGray
        nameTextView.font = .systemFont(ofSize: 20, weight: .bold)
        contentTextView.font = .systemFont(ofSize: 15, weight: .light)
        
        view.addSubview(nameTextView)
        view.addSubview(contentTextView)
        
        completeBarButton.title = "완료"
        navigationItem.rightBarButtonItem = completeBarButton
        
        nameTextView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
