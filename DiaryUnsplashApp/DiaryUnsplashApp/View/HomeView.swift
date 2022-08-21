//
//  HomeView.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit

final class HomeView: BaseView {
    
    lazy var homeImageView = UIImageView()
    lazy var moveToImageViewButton = UIButton()
    private lazy var nameTextField = UITextField()
    private lazy var subNameTextField = UITextField()
    lazy var descriptionTextView = UITextView()
    private let largeConfigure = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
    
    override func configureView() {
        self.backgroundColor = .systemGray
        [homeImageView,moveToImageViewButton, nameTextField, subNameTextField, descriptionTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        setHomeImageView()
        setMoveToImageViewButton()
        setNameTextField()
        setSubNameTextField()
        setDescriptionTextView()
    }
    
    private func setHomeImageView() {
        homeImageView.backgroundColor = .black
        NSLayoutConstraint.activate([
            homeImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            homeImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            homeImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            homeImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setMoveToImageViewButton() {
        let buttonImage = UIImage(systemName: "circle.fill", withConfiguration: largeConfigure)
        moveToImageViewButton.setImage(buttonImage, for: .normal)
        moveToImageViewButton.tintColor = .systemIndigo
        NSLayoutConstraint.activate([
            moveToImageViewButton.trailingAnchor.constraint(equalTo: homeImageView.trailingAnchor, constant: -16),
            moveToImageViewButton.bottomAnchor.constraint(equalTo: homeImageView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setNameTextField() {
        nameTextField.backgroundColor = .systemCyan
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: homeImageView.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: homeImageView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func setSubNameTextField() {
        subNameTextField.backgroundColor = .systemIndigo
        NSLayoutConstraint.activate([
            subNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            subNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subNameTextField.widthAnchor.constraint(equalTo: homeImageView.widthAnchor),
            subNameTextField.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func setDescriptionTextView() {
        descriptionTextView.backgroundColor = .brown
        descriptionTextView.font = .preferredFont(forTextStyle: .largeTitle, compatibleWith: .current)
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: subNameTextField.bottomAnchor, constant: 16),
            descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: homeImageView.widthAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
