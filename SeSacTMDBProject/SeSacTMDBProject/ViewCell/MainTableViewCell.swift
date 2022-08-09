//
//  MainTableViewCell.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        mainTitleLabel.font = .boldSystemFont(ofSize: 24)
        mainTitleLabel.text = "넷플릭스 인기 콘텐츠"
        mainTitleLabel.backgroundColor = .clear
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
