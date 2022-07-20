//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/20.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    func configureCell(data: Movie) {
        titleLabel.text = data.title
        titleLabel.font = .boldSystemFont(ofSize: 15)
        releaseLabel.text = "2222.22.22"
        overViewLabel.text = data.overview
        overViewLabel.numberOfLines = 0
    }
}
