//
//  ValidationViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/27.
//

import UIKit

import RxCocoa
import RxSwift

final class ValidationViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!
    @IBOutlet private weak var stepButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.validText
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation =  nameTextField.rx.text.orEmpty
            .map { $0.count >= 8 }
            .share()
        
        //subscribe 사용시
        //            .subscribe(onNext: { value in
        //                self.stepButton.isEnabled = value
        //                self.validationLabel.isHidden = value
        //            })
        
        validation
        //bind -> error가 절대 나지 않을 때
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
        //        리소스 정리, 위의 코드들을 버린다고 생각하면됨
            .disposed(by: disposeBag)
        
        validation
            .withUnretained(self)
            .bind { vc, value in
                let color: UIColor = value ? .systemPink : .lightGray
                vc.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        stepButton.rx.tap
            .bind { _ in
                print("SHOW ALERT")
            }
            .disposed(by: disposeBag)
    }
    
    private func observableSubject() {
        
        let testA = stepButton.rx.tap
            .map { "안녕하세요" }
            .asDriver(onErrorJustReturn: "")
        //            .share()
        
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(validationLabel.rx.text)
        //            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(validationLabel.rx.text)
        //            .bind(to: stepButton.rx.title())
            .disposed(by: disposeBag)
        
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
    }
}
