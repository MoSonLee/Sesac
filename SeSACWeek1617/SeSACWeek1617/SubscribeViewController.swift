//
//  SubscribeViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/26.
//

import UIKit

import RxCocoa
import RxSwift

final class SubscribeViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var label: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    // tap > label: "안녕 반가워"
    // 네트워크 통신이나 파일 다운로드 등 백그라운드 작업
        button.rx.tap
            .observe(on: MainScheduler.instance) //다른 쓰레드로 동작하게 변경
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //4. bind: subsribe, mainschedular error X
        // 무조건 메인 쓰레드에서 작동
        button.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        //5. operator로 데이터의 stream 조작
        button.rx.tap
            .map{ "안녕 반가워"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        //6. driver traits: bind + stream 공유(리소스 낭비 방지, share())
        // Relay와 driver는 연관됐음
        button.rx.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
}
