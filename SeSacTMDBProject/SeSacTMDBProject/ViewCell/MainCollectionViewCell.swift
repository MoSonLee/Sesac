//
//  MainCollectionViewCell.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.cardImageView.backgroundColor = .lightGray
    }
}
