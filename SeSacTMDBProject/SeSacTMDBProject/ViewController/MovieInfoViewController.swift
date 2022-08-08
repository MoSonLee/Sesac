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
    private lazy var castingList: [TMDBCastModel] = []
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieInfoTableView: UITableView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var downArrowbutton: UIButton!
    @IBOutlet weak var overViewTitleLabel: UILabel!
    @IBOutlet weak var movieBackIgroundImage: UIImageView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    var movieTitleData: String?
    var moviePosterImageData: String?
    var movieBackgroundImageData: String?
    var descriptionData: String?
    var idData: Int?
    var sendData: [sendDataModel]?
    var downButtonClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCasting(idData!)
        setNavigationItem()
        setView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        castingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoTableViewCell", for: indexPath) as? MovieInfoTableViewCell else { return UITableViewCell()}
        cell.castProfileImage.image = UIImage(systemName: "circle.fill")
        cell.castOriginalNameLabel.text = castingList[indexPath.row].originalName ?? ""
        cell.castMovieNameLabel.text = castingList[indexPath.row].charcterName ?? ""
        let imageURLString = "\(ImagePoint.ImageFirstKey)\(castingList[indexPath.row].profileImageURL)"
        let imageURL = URL(string: imageURLString)
        cell.castProfileImage.kf.setImage(with: imageURL)
        cell.castProfileImage.contentMode = UIView.ContentMode.scaleAspectFit
        return cell
    }
    
    @IBAction func downarrowButtonTapped(_ sender: UIButton) {
        var newFrame = descriptionView.frame
        if downButtonClicked == false {
            newFrame.size.height = 300
            movieDescriptionLabel.numberOfLines = 0
            descriptionView.frame = newFrame
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            downButtonClicked = true
        } else {
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            newFrame.size.height = 200
            movieDescriptionLabel.numberOfLines = 2
            descriptionView.frame = newFrame
            downButtonClicked = false
        }
    }
    
    private func requestCasting(_ data: Int) {
        hud.show(in: self.view)
        APIManager.shared.requestCasting(data: idData!) { idData, castingList in
            self.idData = idData
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
        
        movieTitleLabel.text = movieTitleData
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.font = .boldSystemFont(ofSize: 25)
        
        overViewTitleLabel.text = "OverView"
        overViewTitleLabel.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
        overViewTitleLabel.adjustsFontSizeToFitWidth = true
        overViewTitleLabel.font = .boldSystemFont(ofSize: 22)
        overViewTitleLabel.textColor = .systemGray
        
        movieDescriptionLabel.text = descriptionData
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.numberOfLines = 2
        
        downArrowbutton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        downArrowbutton.setTitle("", for: .normal)
        downArrowbutton.tintColor = .black
        
        let imageURL = URL(string: moviePosterImageData!)
        let backgroundImageURL = URL(string: movieBackgroundImageData!)
        moviePosterImage.kf.setImage(with: imageURL)
        movieBackIgroundImage.kf.setImage(with: backgroundImageURL)
        movieBackIgroundImage.contentMode = UIView.ContentMode.scaleToFill
    }
}
