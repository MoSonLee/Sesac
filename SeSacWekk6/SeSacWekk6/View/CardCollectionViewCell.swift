//
//  CardCollectionViewCell.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    //변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.cardImageView.backgroundColor = .lightGray
        cardView.cardImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
}
