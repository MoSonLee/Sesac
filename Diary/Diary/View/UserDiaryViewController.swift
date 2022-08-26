//
//  UserDiaryViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

import RealmSwift

final class UserDiaryViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let localRealm = try! Realm()
    
    var diary: [Diary] = []
    var task: [UserDiary] = []
    var realmImage = UIImage()
    var objectID = ObjectId()
    var systemImage = UIImage(systemName: "questionmark.circle.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        collectionViewRegisterAndDelegate()
    }
    
    private func setConfigure() {
        view.backgroundColor = .systemGray
        collectionView.backgroundColor = .systemGray
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setNavigationItems()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        collectionView.collectionViewLayout = setRealmCollectionViewLayout()
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        let deleteButton = UIBarButtonItem(title: "서버 데이터 보러가기", style: .plain, target: self, action: #selector(moveToRealmView))
        let saveButton = UIBarButtonItem(title: "서버에 저장하기", style: .plain, target: self, action: #selector(addRealm))
        self.navigationItem.rightBarButtonItems = [deleteButton, saveButton]
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        deleteButton.tintColor = .red
        saveButton.tintColor = .black
    }
    
    private func collectionViewRegisterAndDelegate() {
        collectionView.register(UserDiaryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: UserDiaryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setRealmCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = ((UIScreen.main.bounds.width / 4))
        layout.itemSize = CGSize(width: width, height: width * 2)
        return layout
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
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
        let task = task.popLast()
        do {
            try localRealm.write {
                localRealm.add(task!)
            }
        }
        catch let error {
            print((error))
        }
        let image = realmImage
        saveButton(fileName: "\(objectID)", image: image)
        
        self.view.makeToast("realm Succeeded")
    }
    
    @objc private func moveToRealmView() {
        let vc = RealmViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
}

extension UserDiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDiaryCollectionViewCell.identifier, for: indexPath) as? UserDiaryCollectionViewCell else { return UICollectionViewCell()}
        
        cell.backgroundColor = .systemIndigo
        cell.userDiaryDescriptionTextView.isEditable = false
        cell.userDiaryTitle.text = diary[indexPath.row].diaryTitle
        cell.userDiaryDescriptionTextView.text = diary[indexPath.row].dirayDescription
        cell.userDiaryImageView.image = diary[indexPath.row].diaryImage
        realmImage = cell.userDiaryImageView.image ?? systemImage!
        
        let data = UserDiary(diaryTitle: diary[indexPath.row].diaryTitle, diaryContent: diary[indexPath.row].dirayDescription)
        task.append(data)
        objectID = task[indexPath.row].objectId
        
        return cell
    }
}
