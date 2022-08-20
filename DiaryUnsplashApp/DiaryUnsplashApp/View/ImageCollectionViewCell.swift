//
//  ImageCollectionViewCell.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    lazy var searchedImage = UIImageView()
    
    static var identifier: String {
        "ImageCollectionViewCell"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpImageCell()
    }
    
    private func setUpImageCell() {
        self.addSubview(searchedImage)
        searchedImage.image = UIImage(named: "profileImage")
        searchedImage.contentMode = .scaleAspectFit
        searchedImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchedImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -8),
            searchedImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8),
            searchedImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchedImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            searchedImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
}
