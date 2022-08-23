//
//  HomeViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var moveToDirayButton = UIButton()
    private lazy var moveToCameraButton = UIButton()
    var diaryTitleLabel = UILabel()
    var diaryDescriptionTextView = UITextView()
    var selectedImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
    }
    
    private func setConfigure() {
        view.backgroundColor = .black
        
        [moveToDirayButton, moveToCameraButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel?.textAlignment = .center
            $0.backgroundColor = .systemGray
            $0.layer.cornerRadius = 16
        }
        
        [diaryTitleLabel, diaryDescriptionTextView, selectedImageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .systemGray
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
        
        moveToDirayButton.setTitle("다이어리 작성하기", for: .normal)
        moveToCameraButton.setTitle("사진 촬영하러가기", for: .normal)
        diaryTitleLabel.font = .preferredFont(forTextStyle: .largeTitle, compatibleWith: .current)
        diaryDescriptionTextView.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
        
        moveToDirayButton.addTarget(self, action: #selector(moveToDiaryButtonTapped), for: .touchUpInside)
        moveToCameraButton.addTarget(self, action: #selector(moveToCameraButtonTapped), for: .touchUpInside)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moveToDirayButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            moveToDirayButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToDirayButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            moveToCameraButton.topAnchor.constraint(equalTo: moveToDirayButton.bottomAnchor, constant: 16),
            moveToCameraButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToCameraButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            diaryTitleLabel.topAnchor.constraint(equalTo: moveToCameraButton.bottomAnchor, constant: 32),
            diaryTitleLabel.leadingAnchor.constraint(equalTo: moveToCameraButton.leadingAnchor),
            diaryTitleLabel.trailingAnchor.constraint(equalTo: moveToCameraButton.trailingAnchor),
            diaryTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            diaryDescriptionTextView.topAnchor.constraint(equalTo: diaryTitleLabel.bottomAnchor, constant: 16),
            diaryDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            diaryDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            diaryDescriptionTextView.heightAnchor.constraint(equalTo: diaryTitleLabel.heightAnchor, multiplier: 3),
            
            selectedImageView.topAnchor.constraint(equalTo: diaryDescriptionTextView.bottomAnchor, constant: 32),
            selectedImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            selectedImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            selectedImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func moveToDiaryButtonTapped() {
        let vc = DiaryViewController()
        vc.saveButtonActionHandler = { titleValue, descriptionValue in
            self.diaryTitleLabel.text = titleValue
            self.diaryDescriptionTextView.text = descriptionValue
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .flipHorizontal
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @objc private func moveToCameraButtonTapped() {
        let vc = CameraViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalTransitionStyle = .partialCurl
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
