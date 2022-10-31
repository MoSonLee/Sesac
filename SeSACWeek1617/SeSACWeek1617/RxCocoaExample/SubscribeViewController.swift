//
//  SubscribeViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/26.
//

import UIKit

import RxAlamofire
import RxCocoa
import RxSwift
import RxDataSources

final class SubscribeViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxAlamofire()
        testRxDataSource()
        //        Observable.of(1,2,3,4,5,6,7,8,9,10)
        //            .skip(3)
        //            .debug()
        //            .filter{ $0 % 2 == 0 }
        //            .map { $0 * 2 }
        //            .subscribe { value in
        //                print("===\(value)")
        //            }
        //            .disposed(by: disposeBag)
        
        let sample = button.rx.tap
        
        // tap > label: "안녕 반가워"
        // 네트워크 통신이나 파일 다운로드 등 백그라운드 작업
        sample
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
    
    private func testRxAlamofire() {
        // Success Error => <Single>
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe { value in
                print(value.results[0].likes)
            }
            .disposed(by: disposeBag)
    }
    
    private func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
                                                                                         
        Observable.just([
            SectionModel(model: "title", items: [1, 2, 3]),
            SectionModel(model: "title1", items: [4, 5, 6]),
            SectionModel(model: "title2", items: [7, 8, 9])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}
