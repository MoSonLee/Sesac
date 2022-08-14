//
//  MovieInfoViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import JGProgressHUD

final class MovieInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private lazy var hud = JGProgressHUD()
    private lazy var castingList: [Cast] = []
    
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieInfoTableView: UITableView!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var downArrowbutton: UIButton!
    @IBOutlet private weak var overViewTitleLabel: UILabel!
    @IBOutlet private weak var movieBackIgroundImage: UIImageView!
    @IBOutlet private weak var moviePosterImage: UIImageView!
    
    var model: TMDBModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCasting(model.movieID)
        setNavigationItem()
        setView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        castingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as? MovieInfoTableViewCell else { return UITableViewCell()}
        cell.configureCell(cast: castingList[indexPath.row])
        return cell
    }
    
    @IBAction private func downarrowButtonTapped(_ sender: UIButton) {
        var newFrame = descriptionView.frame
        sender.isSelected = !sender.isSelected
        sender.isSelected ? toggle(): toggleCancel()
        
        func toggle() {
            newFrame.size.height = 300
            movieDescriptionLabel.numberOfLines = 0
            descriptionView.frame = newFrame
        }
        
        func toggleCancel() {
            newFrame.size.height = 200
            movieDescriptionLabel.numberOfLines = 2
            descriptionView.frame = newFrame
        }
    }
    
    private func requestCasting(_ data: Int) {
        hud.show(in: self.view)
        APIManager.shared.requestCasting(id: model?.movieID ?? 0) { idData, castingList in
            self.castingList.append(contentsOf: castingList)
            DispatchQueue.main.async {
                self.movieInfoTableView.reloadData()
                self.hud.dismiss(animated: true)
            }
        }
    }
    
    @objc
    private func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setNavigationItem() {
        self.navigationItem.title = "출연/제작"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style:.plain, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setView() {
        
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        guard let model = model else { return }
        
        movieTitleLabel.text = model.movieTitle
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.font = .boldSystemFont(ofSize: 25)
        
        overViewTitleLabel.text = "OverView"
        overViewTitleLabel.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
        overViewTitleLabel.adjustsFontSizeToFitWidth = true
        overViewTitleLabel.font = .boldSystemFont(ofSize: 22)
        overViewTitleLabel.textColor = .systemGray
        
        movieDescriptionLabel.text = model.movieDescription
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.numberOfLines = 2
        
        downArrowbutton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        downArrowbutton.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        downArrowbutton.setTitle("", for: .normal)
        downArrowbutton.tintColor = .black
        
        let imageURL = URL(string: ImagePoint.ImageFirstKey + model.movieImageURL)
        let backgroundImageURL = URL(string: ImagePoint.ImageFirstKey + model.movieBackdropURL)
        moviePosterImage.kf.setImage(with: imageURL)
        movieBackIgroundImage.kf.setImage(with: backgroundImageURL)
        movieBackIgroundImage.contentMode = UIView.ContentMode.scaleToFill
    }
}
