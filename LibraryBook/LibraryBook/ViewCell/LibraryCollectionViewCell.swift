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
    @IBOutlet weak var bookImage: UIImageView!
    
    
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
        
        rateLabel.text = String(data.rate)
        rateLabel.font = .preferredFont(forTextStyle: .callout)
        rateLabel.numberOfLines = 1
        bookImage.sizeToFit()
    }
}
