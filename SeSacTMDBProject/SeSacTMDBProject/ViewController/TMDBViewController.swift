//
//  TMDBViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class TMDBViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet private weak var TMDBCollectionView: UICollectionView!
    
    private var list: [TMDBModel] = []
    private var genreList: [GenreModel] = []
    private var castingList: [TMDBCastModel] = []
    private var movieNumber = 3
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        TMDBCollectionView.register(UINib(nibName: "TMDBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TMDBCollectionViewCell")
        setNavigationItems()
        TMDBCollectionView.collectionViewLayout = setTMDBCollectionViewLayout()
        requestTMDB(totalCount: self.movieNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TMDB", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else { return }
        vc.movieTitleData = list[indexPath.row].movieTitle
        vc.moviePosterImageData = "\(ImagePoint.ImageFirstKey)\(list[indexPath.row].movieImageURL)"
        vc.movieBackgroundImageData = "\(ImagePoint.ImageFirstKey)\(list[indexPath.row].movieBackdropURL)"
        vc.descriptionData = list[indexPath.row].movieDescription
        vc.idData = list[indexPath.row].movieID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TMDBCollectionViewCell", for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell()}
        let imageURLString = "\(ImagePoint.ImageFirstKey)\(list[indexPath.row].movieImageURL)"
        let imageURL = URL(string: imageURLString)
        cell.movieImage.kf.setImage(with: imageURL!)
        cell.rateLabel.text = String((round(list[indexPath.row].movievoteAVG)*100)/100)
        cell.movieTitleLabel.text = list[indexPath.row].movieTitle
        cell.movieAppearanceLabel.text = list[indexPath.row].movieDescription
        cell.releaseDateLabel.text = list[indexPath.row].movieReleaseDate
        cell.configureCell()
        cell.configureCellShadow()
        cell.movieButtonPressed = {
            let storyboard = UIStoryboard(name: "TMDB", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
            vc.movieIDData = self.list[indexPath.row].movieID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style:.plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style:.plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func requestTMDB(totalCount: Int) {
        let url = APIKEY.TMDBURLWithMyKey
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in self.list.count ..< self.movieNumber {
                    let index = json["results"][i]
                    let movieID = index["id"].intValue
                    let movieReleaseDate = index["release_date"].stringValue
                    let movieTitle = index["title"].stringValue
                    let movieDescription = index["overview"].stringValue
                    let movieURL = index["poster_path"].stringValue
                    let movieAvg = index["vote_average"].doubleValue
                    let movieBackdrop = index["backdrop_path"].stringValue
                    let data = TMDBModel(movieID: movieID, movieReleaseDate: movieReleaseDate , movieTitle: movieTitle, movievoteAVG: movieAvg, movieImageURL: movieURL, movieBackdropURL: movieBackdrop, movieDescription: movieDescription)
                    self.list.append(data)
                }
                self.TMDBCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TMDBViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = TMDBCollectionView.contentSize.height
        let pagination_y = collectionViewContentSize * 0.5
        if contentOffset_y > pagination_y{
            movieNumber += 2
            requestTMDB(totalCount: self.movieNumber)
            TMDBCollectionView.reloadData()
        }
    }
}

extension UIViewController {
    func setTMDBCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: width, height: width*1.2)
        return layout
    }
}
