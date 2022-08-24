//
//  RealmCollectionViewCell.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

final class UserDiaryCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        "UserDiaryCollectionViewCell"
    }
    
    lazy var userDiaryImageView = UIImageView()
    lazy var userDiaryTitle = UILabel()
    lazy var userDiaryDescriptionTextView = UITextView()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setConfigure()
        setConstraints()
    }
    
    private func setConfigure() {
        [userDiaryImageView, userDiaryTitle, userDiaryDescriptionTextView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        userDiaryImageView.image = UIImage(systemName: "circle.fill")
        userDiaryTitle.text = "AA"
        userDiaryTitle.backgroundColor = .red
        userDiaryDescriptionTextView.text = "AAAAAAAAA"
        userDiaryDescriptionTextView.backgroundColor = .brown
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userDiaryImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            userDiaryImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userDiaryImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            userDiaryImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            userDiaryTitle.topAnchor.constraint(equalTo: userDiaryImageView.bottomAnchor, constant: 16),
            userDiaryTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userDiaryTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            userDiaryDescriptionTextView.topAnchor.constraint(equalTo: userDiaryTitle.bottomAnchor, constant: 16),
            userDiaryDescriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userDiaryDescriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            userDiaryDescriptionTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
