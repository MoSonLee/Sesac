//
//  MovieInfoTableViewCell.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/05.
//

import UIKit

final class MovieInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var castProfileImage: UIImageView!
    @IBOutlet private weak var castOriginalNameLabel: UILabel!
    @IBOutlet private weak var castMovieNameLabel: UILabel!
    
    static let identifier = "MovieInfoTableViewCell"
    
    func configureCell(cast: Cast) {
        castProfileImage.image = UIImage(systemName: "circle.fill")
        castOriginalNameLabel.text = cast.originalName ?? ""
        castMovieNameLabel.text = cast.charcterName ?? ""
        let imageURLString = ImagePoint.ImageFirstKey + (cast.profileImageURL ?? "")
        let imageURL = URL(string: imageURLString)
        castProfileImage.kf.setImage(with: imageURL)
        castProfileImage.contentMode = UIView.ContentMode.scaleAspectFit
    }
}


