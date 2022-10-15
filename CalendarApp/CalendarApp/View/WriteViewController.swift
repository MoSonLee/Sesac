//
//  WriteViewController.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

import Toast
import RealmSwift

protocol diaryDelegate {
    func sendDiary(diary: [Diary])
}

final class WriteViewController: UIViewController {
    
    private lazy var saveButton = UIButton()
    private lazy var moveToCollectionButton = UIButton()
    private lazy var titleTextField = UITextField()
    private lazy var descriptionTextView = UITextView()
    
    var diary: [Diary] = []
    var task: [UserDiary] = []
    var realmImage = UIImage()
    var objectID = ObjectId()
    let localRealm = try! Realm()
    
    var saveButtonActionHandler: (([Diary]) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
    }
    
    
    
    private func setConfigure() {
        view.backgroundColor = .black
        [titleTextField, descriptionTextView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .systemGray
        }
        [saveButton, moveToCollectionButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .white
            $0.backgroundColor = .systemGray
        }
        saveButton.setTitle("저장", for: .normal)
        moveToCollectionButton.setTitle("보관함", for: .normal)
        
        saveButton.addTarget(self, action: #selector(addRealm), for: .touchUpInside)
        moveToCollectionButton.addTarget(self, action: #selector(moveToCollectionButtonTapped), for: .touchUpInside)
        titleTextField.placeholder = "제목을 입력하세요"
        descriptionTextView.font = .preferredFont(forTextStyle: .body, compatibleWith: .current)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            saveButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            saveButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            
            moveToCollectionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            moveToCollectionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            moveToCollectionButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            moveToCollectionButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            
            
            titleTextField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            titleTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            titleTextField.bottomAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: -16),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
        ])
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
        self.view.makeToast("realm Succeeded")
    }
    
    @objc private func doneButtonTapped() {
        if titleTextField.text?.count == 0 {
            self.view.makeToast("제목을 필수로 입력해주세요")
        }
        else {
            showAlert(title: "", message: "일기를 추가할까요?", buttonTitle: "확인") { _ in
                let data = Diary(diaryTitle: self.titleTextField.text!, dirayDescription: self.descriptionTextView.text, diaryDate: Date())
                self.diary.append(data)
                self.view.makeToast("저장 성공")
            }
        }
    }
    
    @objc private func moveToCollectionButtonTapped() {
        let vc = DiaryTableViewController()
        vc.diary = self.diary
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    public func showAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping ((UIAlertAction) -> Void)) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .destructive, handler: buttonAction)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension WriteViewController: diaryDelegate {
    func sendDiary(diary: [Diary]) {
        self.diary = diary
    }
}
