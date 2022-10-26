//
//  SubjectViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift

class SubjectViewController: UIViewController {
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var newButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let publish = PublishSubject<Int>() //초기값이 없는 빈 상태
    let behaivor = BehaviorSubject(value: 100)
    let replay = ReplaySubject<Int>.create(bufferSize: 3) //bufferSize: 작성된 이벤트 갯수만큼 메모리에서 이벤트를 갖고 있다가, subscribe 직후 한번에 이벤트를 전달
    let async = AsyncSubject<Int>()
    let disposeBag = DisposeBag()
    let viewModel = SubjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        publishSubject()
        //        behaviorSubject()
        //        replaySubject()
        //        asyncSubject()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "ContactCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.name): \(element.age)세 \(element.number)"
                
            }
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .subscribe{ (vc, _) in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        newButton.rx.tap
            .withUnretained(self)
            .subscribe{ (vc, _) in
                vc.viewModel.newData()
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .withUnretained(self)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged() 
            .subscribe{ (vc, value) in
                print(value)
                vc.viewModel.filterData(query: value)
            }
            .disposed(by: disposeBag)
    }
}


extension SubjectViewController {
    func asyncSubject() {
        //마지막 하나만 넣어줌
        async.onNext(1)
        async.onNext(2)
        async.onNext(100)
        async
            .subscribe {value in
                print("async - \(value)")
            } onError: { error in
                print("async - \(error)")
            } onCompleted: {
                print("async completed")
            } onDisposed: {
                print("async disposed")
            }
            .disposed(by: disposeBag)
        
        async.onNext(10)
        async.onNext(11)
        async.on(.next(12))
        
        async.onCompleted()
        
        //실행 안됨
        async.onNext(15)
        async.onNext(16)
    }
    
    func replaySubject() {
        //BufferSize 메모리, array, 이미지
        replay.onNext(1)
        replay.onNext(2)
        replay.onNext(100)
        replay
            .subscribe {value in
                print("replay - \(value)")
            } onError: { error in
                print("replay - \(error)")
            } onCompleted: {
                print("replay completed")
            } onDisposed: {
                print("replay disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(10)
        replay.onNext(11)
        replay.on(.next(12))
        
        replay.onCompleted()
        
        //실행 안됨
        replay.onNext(15)
        replay.onNext(16)
    }
    
    func publishSubject() {
        
        //publish
        // observable, observer의 역할을 동시에 수행
        // subscribe 전/Error/ completed notification 이후 이벤트 무시
        // subscribe 후에 대한 이벤트는 다 처리
        publish.onNext(1)
        publish.onNext(2)
        
        publish
            .subscribe {value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish completed")
            } onDisposed: {
                print("publish disposed")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(10)
        publish.onNext(11)
        publish.on(.next(12))
        
        publish.onCompleted()
        
        //실행 안됨
        publish.onNext(15)
        publish.onNext(16)
    }
    
    func behaviorSubject() {
        behaivor.onNext(1)
        behaivor.onNext(2)
        //구독하기 전 가장 최신의 값을 가져옴
        behaivor
            .subscribe {value in
                print("behaivor - \(value)")
            } onError: { error in
                print("behaivor - \(error)")
            } onCompleted: {
                print("behaivor completed")
            } onDisposed: {
                print("behaivor disposed")
            }
            .disposed(by: disposeBag)
        
        behaivor.onNext(10)
        behaivor.onNext(11)
        behaivor.on(.next(12))
        
        behaivor.onCompleted()
        
        //실행 안됨
        behaivor.onNext(15)
        behaivor.onNext(16)
    }
}
