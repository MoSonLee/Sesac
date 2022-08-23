//
//  RealmViewController.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/23.
//

import UIKit

import RealmSwift
import SnapKit

final class RealmViewController: UIViewController {
    
    private lazy var localRealm = try! Realm()
    var tasks: Results<userBuyList>!
    var tableModel: [TableModel] = []
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = localRealm.objects(userBuyList.self).sorted(byKeyPath: "buyList", ascending: false)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        setTableView()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector((backButtonClicked)))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RealmTableViewCell.self, forCellReuseIdentifier: RealmTableViewCell.identifider)
        view.addSubview(tableView)
    }
    
    @objc private func backButtonClicked() {
        self.dismiss(animated: true)
    }
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RealmTableViewCell.identifider) as! RealmTableViewCell
        
        cell.textlabel.text = tasks[indexPath.row].buyList
        cell.textlabel.textAlignment = .center
        cell.starButton.setImage(UIImage(systemName: tasks[indexPath.row].isStarred), for: .normal)
        cell.checkButton.setImage(UIImage(systemName: tasks[indexPath.row].isChecked), for: .normal)
        
        return cell
    }
}
