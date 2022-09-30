//
//  InvestViewController.swift
//  RXStudy
//
//  Created by 이승후 on 2022/08/21.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class InvestViewController: UIViewController {
    
    private let menuBarButton = UIBarButtonItem()
    
    private let hashLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel = InvestViewModel()
    
    private lazy var input = InvestViewModel.Input(
        viewDidLoad: viewDidLoadEvent.asObservable(),
        menuBarButtonTap: menuBarButton.rx.tap.asSignal()
    )
    
    private lazy var output = viewModel.transform(input: input)
    
    let viewDidLoadEvent = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setConfigure()
        setConstraints()
        viewDidLoadEvent.accept(())
    }
    
    
    private func bind() {
        output.accounts
            .drive(tableView.rx.items) { tableView, index, element in
                 let cell = tableView.dequeueReusableCell(withIdentifier: InvestCell.identifider) as!
                InvestCell
                cell.configure(account: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.hashString
            .emit(to: hashLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.titleText
            .emit(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.showAlert
            .emit(onNext :{ text in
                let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: nil, style: .cancel)
                alert.addAction(cancel)
            } )
            .disposed(by: disposeBag)
        
//        menuBarButton.rx.tap.asSignal()
//            .emit(onNext: { [weak self] _ in
//                let vc = EditNoteViewController()
//                self?.navigationController?.pushViewController(vc, animated: true)
//            })
//            .disposed(by: disposeBag)
        
        //input output mvvm형식으로 보낼때
        output.showEditNoteVC
            .emit(onNext: { [weak self] _ in
                let vc = EditNoteViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // set AutoLayout
    private func setConstraints() {
        view.addSubview(tableView)
        view.addSubview(hashLabel)
        
        hashLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(hashLabel.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //UI 수정
    private func setConfigure() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = menuBarButton
        
        hashLabel.textAlignment = .center
        
        menuBarButton.image = UIImage(systemName: "circle.fill")
        menuBarButton.tintColor = .systemOrange
        
        tableView.register(
            InvestCell.self,
            forCellReuseIdentifier: InvestCell.identifider)
        tableView.rowHeight = 200
    }
}
