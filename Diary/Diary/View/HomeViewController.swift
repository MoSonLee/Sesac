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
            $0.tintColor = .white
        }
        moveToDirayButton.setTitle("다이어리 작성하기", for: .normal)
        moveToCameraButton.setTitle("사진 촬영하러가기", for: .normal)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moveToDirayButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            moveToDirayButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToDirayButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            moveToCameraButton.topAnchor.constraint(equalTo: moveToDirayButton.bottomAnchor, constant: 16),
            moveToCameraButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            moveToCameraButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
        ])
    }
}
