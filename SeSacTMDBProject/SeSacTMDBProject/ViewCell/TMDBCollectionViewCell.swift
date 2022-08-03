//
//  TMDBCollectionViewCell.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/03.
//

import UIKit

class TMDBCollectionViewCell: UICollectionViewCell {
    private var list: [TMDBModel] = []
    
    @IBOutlet weak var ViewWithShadow: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var imageButtonLabel: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var rateTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieAppearanceLabel: UILabel!
    @IBOutlet weak var moveToMovieLabel: UILabel!
    @IBOutlet weak var moveToMovieButton: UIButton!
    
    func configureCellShadow() {
        self.ViewWithShadow.layer.cornerRadius = 15.0
        self.ViewWithShadow.layer.borderWidth = 0.0
        self.ViewWithShadow.layer.shadowColor = UIColor.black.cgColor
        self.ViewWithShadow.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.ViewWithShadow.layer.shadowRadius = 10.0
        self.ViewWithShadow.layer.shadowOpacity = 1
        self.ViewWithShadow.layer.masksToBounds = false
    }
    
    func configureCell() {
        self.backgroundColor = .clear
        self.moveToMovieLabel.text = "자세히 보기"
        self.moveToMovieButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        self.moveToMovieButton.tintColor = .black
        self.moveToMovieButton.setTitle("", for: .normal)
        
        self.imageButtonLabel.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        self.imageButtonLabel.tintColor = .black
        self.imageButtonLabel.setTitle("", for: .normal)
        
        self.rateTitleLabel.text = "평점"
        self.rateTitleLabel.backgroundColor = .systemPurple
        self.rateTitleLabel.textAlignment = .center
        self.rateTitleLabel.textColor = .white
        
        self.rateLabel.textAlignment = .center
        self.rateLabel.textColor = .black
        self.rateLabel.backgroundColor = .white
        self.movieTitleLabel.font = .boldSystemFont(ofSize: 22)

        self.movieAppearanceLabel.font = .boldSystemFont(ofSize: 17)
        self.movieAppearanceLabel.textColor = .systemGray
        
        self.movieImage.contentMode = UIView.ContentMode.scaleToFill
        
    }
}
