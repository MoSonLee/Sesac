//
//  LibraryCollectionViewCell.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/20.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var moveToBookWeb: UIButton!
    @IBOutlet weak var bookImage: UIImageView!
    
    private var randomColorArray: [UIColor] = [.systemCyan, .systemRed, .systemPurple, .systemPink, .systemMint, .systemBlue]
    
    
    func configureCell(_ data: Book ) {
        layer.cornerRadius = 16
        
        titleLabel.text = data.title
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        dateLabel.text = data.releaseDate
        dateLabel.font = .preferredFont(forTextStyle: .callout)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        

        moveToBookWeb.setTitle("책 정보", for: .normal)
        moveToBookWeb.titleLabel?.textColor = .black
        moveToBookWeb.setTitleColor(.black, for: .normal)
        moveToBookWeb.titleLabel?.font = .preferredFont(forTextStyle: .callout)
        moveToBookWeb.titleLabel?.sizeToFit()
        moveToBookWeb.backgroundColor = .white
        moveToBookWeb.layer.cornerRadius = 8

        rateLabel.text = String(data.rate)
        rateLabel.font = .preferredFont(forTextStyle: .callout)
        rateLabel.numberOfLines = 1
        bookImage.sizeToFit()
    }
}
