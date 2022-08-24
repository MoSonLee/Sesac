//
//  DiaryViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/23.
//

import UIKit

import Toast

final class DiaryViewController: UIViewController {
    
    private lazy var titleTextField = UITextField()
    private lazy var descriptionTextView = UITextView()
    
    var saveButtonActionHandler: ((String, String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        setNavigationItems()
    }
    
    private func setConfigure() {
        view.backgroundColor = .black
        [titleTextField, descriptionTextView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .systemGray
        }
        titleTextField.placeholder = "제목을 입력하세요"
        descriptionTextView.font = .preferredFont(forTextStyle: .body, compatibleWith: .current)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            titleTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            titleTextField.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setNavigationItems() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        if titleTextField.text?.count == 0 {
            self.view.makeToast("제목을 필수로 입력해주세요")
        }
        else {
            showSesacAlert(title: "", message: "일기를 추가할까요?", buttonTitle: "확인") { _ in
                self.saveButtonActionHandler?(self.titleTextField.text!, self.descriptionTextView.text)
                self.dismiss(animated: true)
            }
        }
    }
    
    public func showSesacAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping ((UIAlertAction) -> Void)) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .destructive, handler: buttonAction)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
