//
//  DiaryTableViewController.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

import RealmSwift
import SnapKit

final class DiaryTableViewController: UIViewController {
    
    private var delegate: diaryDelegate?
    
    var diary: [Diary] = []
    var task: [UserDiary] = []
    var realmImage = UIImage()
    var objectID = ObjectId()
    let localRealm = try! Realm()
    
    lazy var tableView = UITableView()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd/hh:mm"
        return formatter
    }()
    
    static var identifier: String {
        return "SearchViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        setTableView()
        setNavigationItems()
    }
    
    private func setConfigure() {
        view.addSubview(tableView)
        view.backgroundColor = .systemCyan
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        delegate?.sendDiary(diary: diary)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func setNavigationItems() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        let saveButton = UIBarButtonItem(title: "서버에 저장하기", style: .plain, target: self, action: #selector(addRealm))
        let moveButton = UIBarButtonItem(title: "서버로 이동하기", style: .plain, target: self, action: #selector(moveToRealmView))
        self.navigationItem.rightBarButtonItems = [saveButton, moveButton]
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.identifier)
    }
    
    private func saveButton(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로, 이미지를 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    @objc private func addRealm() {
        let task = task
        do {
            try localRealm.write {
                localRealm.add(task)
            }
        }
        catch let error {
            print((error))
        }
        let image = realmImage
        saveButton(fileName: "\(objectID)", image: image)
        
        self.view.makeToast("realm Succeeded")
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }

    @objc private func moveToRealmView() {
        let vc = RealmViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
}

extension DiaryTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        diary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else { return UITableViewCell()}
        cell.backgroundColor = .systemIndigo
        cell.dateLabel.text = diary[indexPath.row].diaryTitle
        cell.descriptionLabel.text = diary[indexPath.row].dirayDescription
        
        let data = UserDiary(diaryTitle: diary[indexPath.row].diaryTitle, diaryContent: diary[indexPath.row].dirayDescription)
        task.append(data)
        objectID = task[indexPath.row].objectId
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
