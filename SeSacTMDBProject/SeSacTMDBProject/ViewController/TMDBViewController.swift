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
import JGProgressHUD


class TMDBViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet private weak var TMDBCollectionView: UICollectionView!
    
    private lazy var hud = JGProgressHUD()
    private lazy var list: [TMDBModel] = []
    private lazy var castingList: [TMDBCastModel] = []
    private lazy var movieNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        TMDBCollectionView.register(UINib(nibName: "TMDBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TMDBCollectionViewCell")
        setNavigationItems()
        TMDBCollectionView.collectionViewLayout = setTMDBCollectionViewLayout()
        requestTMDB()
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
    
    private func requestTMDB() {
        hud.show(in: self.view)
        APIManager.shared.requestTMDB(movieNumber: movieNumber) { movieNumber, list in
            self.movieNumber = movieNumber
            self.list.append(contentsOf: list)
            DispatchQueue.main.async {
                self.TMDBCollectionView.reloadData()
                self.hud.dismiss(animated: true)
            }
        }
    }
}

extension TMDBViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = TMDBCollectionView.contentSize.height
        let pagination_y = collectionViewContentSize * 0.2
        if contentOffset_y > pagination_y{
            movieNumber += 10
            requestTMDB()
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
