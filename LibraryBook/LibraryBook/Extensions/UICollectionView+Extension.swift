//
//  UICollectionView+Extension.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/20.
//

import UIKit

extension UICollectionView {
    func setCoolectionViewLayout(_ count: Int) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * (CGFloat(count) + 1))
        let height = UIScreen.main.bounds.height -  (spacing * 4)
        layout.itemSize = CGSize(width: width / 2 * 1.1 , height: height / 5 * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
}
