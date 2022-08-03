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
    
    @IBOutlet weak var TMDBCollectionView: UICollectionView!
    private var list: [TMDBModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        TMDBCollectionView.register(UINib(nibName: "TMDBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TMDBCollectionViewCell")
        setNavigationItems()
        TMDBCollectionView.collectionViewLayout = setTMDBCollectionViewLayout()
        requestTMDB()
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
        return cell
    }
    
    private func setNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style:.plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style:.plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    private func requestTMDB() {
        let url = APIKEY.TMDBURLWithMyKey
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0..<20 {
                    let movieReleaseDate = json["results"][index]["release_date"].stringValue
                    let movieTitle = json["results"][index]["title"].stringValue
                    let movieDescription = json["results"][index]["overview"].stringValue
                    let movieURL = json["results"][index]["poster_path"].stringValue
                    let movieAvg = json["results"][index]["vote_average"].doubleValue
                    let data = TMDBModel(movieReleaseDate: movieReleaseDate , movieTitle: movieTitle, movievoteAVG: movieAvg, movieImageURL: movieURL, movieDescription: movieDescription)
                    self.list.append(data)
                }
                self.TMDBCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
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
