//
//  HomeViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/23.
//

import UIKit

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

final class HomeViewController: UIViewController {
    
    private lazy var moveToDirayButton = UIButton()
    private lazy var moveToCameraButton = UIButton()
   
    private lazy var moveToImageSearchButton = UIButton()
    private lazy var moveToUserDiary = UIButton()
    
    var diaryTitleLabel = UILabel()
    var diaryDescriptionTextView = UITextView()
    var selectedImageView = UIImageView()
    var systemImage = UIImage(systemName: "questionmark.circle.fill")
    
    var diary: [Diary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
    }
    
    private func setConfigure() {
        view.backgroundColor = .black
        
        [moveToDirayButton, moveToCameraButton,moveToImageSearchButton, moveToUserDiary].forEach {
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
        moveToImageSearchButton.setTitle("사진 검색하러 가기", for: .normal)
        moveToUserDiary.setTitle("현재 다이어리를 저장하기", for: .normal)
        
        diaryTitleLabel.font = .preferredFont(forTextStyle: .largeTitle, compatibleWith: .current)
        diaryDescriptionTextView.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
        
        moveToDirayButton.addTarget(self, action: #selector(moveToDiaryButtonTapped), for: .touchUpInside)
        moveToCameraButton.addTarget(self, action: #selector(moveToCameraButtonTapped), for: .touchUpInside)
        moveToImageSearchButton.addTarget(self, action: #selector(moveToImageSearchButtonTapped), for: .touchUpInside)
        moveToUserDiary.addTarget(self, action: #selector(moveToUserDiaryView), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moveToDirayButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            moveToDirayButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToDirayButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            moveToCameraButton.topAnchor.constraint(equalTo: moveToDirayButton.bottomAnchor, constant: 16),
            moveToCameraButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToCameraButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            moveToImageSearchButton.topAnchor.constraint(equalTo: moveToCameraButton.bottomAnchor, constant: 16),
            moveToImageSearchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToImageSearchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            moveToUserDiary.topAnchor.constraint(equalTo: moveToImageSearchButton.bottomAnchor, constant: 16),
            moveToUserDiary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToUserDiary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            
            diaryTitleLabel.topAnchor.constraint(equalTo:
                                                    moveToUserDiary.bottomAnchor, constant: 32),
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
        vc.modalTransitionStyle = .flipHorizontal
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc private func moveToCameraButtonTapped() {
        let vc = CameraViewController()
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    @objc private func moveToImageSearchButtonTapped() {
        let vc = SearchImageViewController()
        vc.delegate = self
        vc.completionHandler = { sendImage in
            self.selectedImageView.image = sendImage
        }
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    @objc private func moveToUserDiaryView() {
        if diaryTitleLabel.text == "" {
            self.view.makeToast("다이어리 추가하고 저장해주세요!")
        } else {
            let data = Diary(diaryTitle: diaryTitleLabel.text ?? "", dirayDescription: diaryDescriptionTextView.text, diaryImage: selectedImageView.image ?? systemImage)
            diary.append(data)
            let vc = UserDiaryViewController()
            vc.diary = diary
            transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
}

extension HomeViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        self.selectedImageView.image = image
    }
}
