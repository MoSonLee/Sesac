//
//  RealmViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

import SnapKit
import RealmSwift

final class RealmViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: false)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        setNavigationItems()
    }
    
    private func setConfigure() {
        view.backgroundColor = .systemGray
        setTableView()
    }
    
    private func setConstraints() {
        
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RealmTableViewCell.self, forCellReuseIdentifier: RealmTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RealmTableViewCell.identifier) as? RealmTableViewCell else { return UITableViewCell()}
        
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.descriptionLabel.text = tasks[indexPath.row].diaryContent
        cell.realmImage.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
