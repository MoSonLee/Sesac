//
//  HomeViewController.swift
//  SesacRealm
//
//  Created by 이승후 on 2022/08/22.
//

import UIKit

import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private lazy var headerView = UIView()
    private lazy var headerTextField = UITextField()
    private lazy var headerAddButton = UIButton()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel = HomeViewModel()
    
    private lazy var input = HomeViewModel.Input(
        viewDidLoad: viewDidLoadEvent.asObservable()
    )
    private lazy var output = viewModel.transform(input: input)
    
    let viewDidLoadEvent = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        bind()
    }
    
    private func bind() {
        output.tableViewModel
            .drive(tableView.rx.items) { tableView, index, element in
                 let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifider) as!
                HomeTableViewCell
                cell.textlabel.text = element.labelText
                cell.checkButton.setImage(UIImage(systemName: element.checkButtonString), for: .normal)
                cell.starButton.setImage(UIImage(systemName: element.starButtonString), for: .normal)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func setConfigure() {
        view.backgroundColor = .lightGray
        headerView.backgroundColor = .white
        headerAddButton.backgroundColor = .darkGray
        
        headerTextField.placeholder = "무엇을 입력하실 건가요?"
        headerAddButton.titleLabel?.text = "추가"
        headerAddButton.setTitle("추가", for: .normal)
        [headerView, headerTextField, headerAddButton, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 8
        }
        
        tableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifider)
        tableView.rowHeight = 50
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            headerAddButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerAddButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerAddButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.1),
            
            headerTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            headerTextField.trailingAnchor.constraint(equalTo: headerAddButton.leadingAnchor, constant: 8),
            headerTextField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ])
    }
}

