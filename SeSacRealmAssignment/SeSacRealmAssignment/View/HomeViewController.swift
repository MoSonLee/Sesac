//
//  HomeViewController.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/22.
//

import UIKit

import RealmSwift
import RxCocoa
import RxSwift
import Toast


final class HomeViewController: UIViewController {
    
    private lazy var headerView = UIView()
    private lazy var moveToRealmButton = UIButton()
    private lazy var headerTextField = UITextField()
    private lazy var headerAddButton = UIButton()
    private lazy var tableModel: [TableModel] = []
    var isStarSelected: Bool = false
    var isCheckBoxselected: Bool = false
    
    private let disposeBag = DisposeBag()
    
    let localRealm = try! Realm()
    
    private var tableCellArray: [TableModel] = [
        TableModel(checkButtonString: "checkmark.square", labelText: "아이폰 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "맥북 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이패드 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이맥 구매하기", starButtonString: "star")
    ]
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        setTableViewData()
        addCellButtonClikced()
        
        moveToRealmButton.rx.tap
            .bind {
                let vc = RealmViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .flipHorizontal
                self.present(nav, animated: true)
                for index in 0..<self.tableModel.count {
                    self.configure(tableModel: self.tableModel[index])
                }
            }.disposed(by: disposeBag)
       
//        tableView.reloadData()
    }
    
    private func setConfigure() {
        view.backgroundColor = .lightGray
        headerView.backgroundColor = .white
        headerAddButton.backgroundColor = .darkGray
        moveToRealmButton.backgroundColor = .systemCyan
        
        headerTextField.placeholder = "무엇을 입력하실 건가요?"
        headerAddButton.setTitle("추가", for: .normal)
        moveToRealmButton.setTitle("이동", for: .normal)
        [headerView, headerTextField, headerAddButton, tableView, moveToRealmButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 8
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            moveToRealmButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            moveToRealmButton.trailingAnchor.constraint(equalTo: headerAddButton.leadingAnchor, constant: -16),
            moveToRealmButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.2),
            
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
    
    private func setTableViewData() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifider)
        tableView.rowHeight = 50
        for index in 0..<tableCellArray.count {
            tableModel.append(tableCellArray[index])
        }
    }
    
    //rx와 친해지자..
    private func addCellButtonClikced() {
        headerAddButton.rx.tap
            .bind { [self] in
                if headerTextField.text == "" {
                    self.view.makeToast("할 일을 입력해주세요")
                } else {
                    let data =  TableModel(checkButtonString: "checkmark.square", labelText: headerTextField.text!, starButtonString: "star")
                    tableModel.insert(data, at: 0)
                    tableView.beginUpdates()
                    tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                    tableView.endUpdates()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToRelamButtonClicked() {
        moveToRealmButton.rx.tap
            .bind {
                let vc = RealmViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .flipHorizontal
                self.present(nav, animated: true)
            }.disposed(by: disposeBag)
        for index in 0..<tableModel.count - 1 {
            configure(tableModel: tableModel[index])
        }
    }
    
    func configure(tableModel: TableModel) {
        let task = userBuyList(buyList: tableModel.labelText, isStarred: tableModel.starButtonString, isChecked: tableModel.checkButtonString)
        try! self.localRealm.write{
            self.localRealm.add(task)
            print("realm Succeeded")
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifider) as? HomeTableViewCell else { return UITableViewCell() }
        cell.configure(tableModel: tableModel[indexPath.row])
        cell.starButton.rx.tap
            .bind{
                if self.isStarSelected {
                    self.tableModel[indexPath.row].starButtonString = "star.fill"
                    cell.starButton.setImage(UIImage(systemName:  self.tableModel[indexPath.row].starButtonString), for: .normal)
                    self.isStarSelected = !self.isStarSelected
                } else {
                    self.tableModel[indexPath.row].starButtonString = "star"
                    cell.starButton.setImage(UIImage(systemName: self.tableModel[indexPath.row].starButtonString), for: .normal)
                    self.isStarSelected = !self.isStarSelected
                }
            }.disposed(by: disposeBag)
        
        cell.checkButton.rx.tap
            .bind{
                if self.isCheckBoxselected {
                    self.tableModel[indexPath.row].checkButtonString = "checkmark.square.fill"
                    cell.checkButton.setImage(UIImage(systemName: self.tableModel[indexPath.row].checkButtonString), for: .normal)
                    self.isCheckBoxselected = !self.isCheckBoxselected
                } else {
                    self.tableModel[indexPath.row].checkButtonString = "checkmark.square"
                    cell.checkButton.setImage(UIImage(systemName: self.tableModel[indexPath.row].checkButtonString), for: .normal)
                    self.isCheckBoxselected = !self.isCheckBoxselected
                }
            }.disposed(by: disposeBag)
        return cell
    }
}
