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
    var removeId: ObjectId?
    
    lazy var taskArray = Array(tasks)
    
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
        view.backgroundColor = .white
        setTableView()
    }
    
    private func setConstraints() {
        
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        let deleteButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(method))
        let saveButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(method))
        self.navigationItem.rightBarButtonItems = [deleteButton, saveButton]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        deleteButton.tintColor = .black
        saveButton.tintColor = .black
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
        taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RealmTableViewCell.identifier) as? RealmTableViewCell else { return UITableViewCell()}
        
        cell.titleLabel.text = taskArray[indexPath.row].diaryTitle
        cell.descriptionLabel.text = taskArray[indexPath.row].diaryContent
        cell.realmImage.image = loadImageFromDocument(fileName: "\(taskArray[indexPath.row].objectId)")
        removeId = taskArray[indexPath.row].objectId
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            removeImageFormDocument(fileName: "\(tasks[indexPath.row].objectId)")
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
