//
//  MainViewController.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/22.
//

import UIKit

import SnapKit
import RealmSwift

final class MainViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tasks = localRealm.objects(userDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector((starButtonClicked)))
        let left1Button = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector((sortButtonClicked)))
        let left2Button = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector((filterButtonClicked)))
        navigationItem.leftBarButtonItems = [left1Button, left2Button]
        
    }
    
    @objc func starButtonClicked() {
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks =  localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryRegisterDate")
        tableView.reloadData()
    }
    
    @objc func filterButtonClicked() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
}
