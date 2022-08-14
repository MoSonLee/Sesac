//
//  TMDBCollectionViewCell.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/03.
//

import UIKit

final class TMDBCollectionViewCell: UICollectionViewCell {
    private var list: [TMDBModel] = []
    
    @IBOutlet private weak var ViewWithShadow: UIView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var movieGenreLabel: UILabel!
    @IBOutlet private weak var imageButtonLabel: UIButton!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var rateTitleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieAppearanceLabel: UILabel!
    @IBOutlet private weak var moveToMovieLabel: UILabel!
    @IBOutlet private weak var moveToMovieButton: UIButton!
    
    static var identifier: String {
        return "TMDBCollectionViewCell"
    }
    
    var movieButtonPressed: (() -> Void)?
    
    func configureShadow() {
        self.ViewWithShadow.layer.cornerRadius = 15.0
        self.ViewWithShadow.layer.borderWidth = 0.0
        self.ViewWithShadow.layer.shadowColor = UIColor.black.cgColor
        self.ViewWithShadow.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.ViewWithShadow.layer.shadowRadius = 10.0
        self.ViewWithShadow.layer.shadowOpacity = 1
        self.ViewWithShadow.layer.masksToBounds = false
    }
    
    func configure(model: TMDBModel) {
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
        
        self.movieImage.contentMode = .scaleAspectFill
        
        let imageURLString = ImagePoint.ImageFirstKey + model.movieImageURL
        let imageURL = URL(string: imageURLString)
        movieImage.kf.setImage(with: imageURL!)
        rateLabel.text = "\((round(model.movievoteAVG)*100)/100)"
        movieTitleLabel.text = model.movieTitle
        movieAppearanceLabel.text = model.movieDescription
        releaseDateLabel.text = model.movieReleaseDate
    }

    @IBAction func moveToMovieButtonTapped(_ sender: UIButton) {
        movieButtonPressed?()
    }
}
