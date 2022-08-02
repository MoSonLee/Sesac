//
//  BeerListViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

final class BeerListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var beerCollectionView: UICollectionView!
    private var list: [BeerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        beerCollectionView.register(UINib(nibName: "BeerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BeerCollectionViewCell")
        beerCollectionView.collectionViewLayout = setCollectionViewLayout()
        requestBeer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .systemGray
        cell.beerNameLabel.font = .boldSystemFont(ofSize: 17)
        cell.beerValueLabel.font = .boldSystemFont(ofSize: 8)
        cell.beerNameLabel.text = list[indexPath.row].beerTitle
        cell.beerValueLabel.text = list[indexPath.row].beerValue
        cell.beerValueLabel.numberOfLines = 2
        let errorURL = URL(string: "https://www.geochang.go.kr/portal/popup/20190111/20190111.gif")
        if list[indexPath.row].beerImageURL == nil {
            cell.beerImageView.kf.setImage(with: errorURL )
        } else {
            cell.beerImageView.kf.setImage(with: list[indexPath.row].beerImageURL )
        }
        return cell
    }
    
    private func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0..<json[][].arrayValue.count {
                    let beerName = json[index]["name"].stringValue
                    let beerValue = json[index]["tagline"].stringValue
                    let beerImageURL = json[index]["image_url"].url
                    let data = BeerModel(beerTitle: beerName, beerValue: beerValue, beerImageURL: beerImageURL)
                    print(data)
                    self.list.append(data)
                }
                print(self.list)
                self.beerCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UIViewController {
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width / 3 - spacing
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        return layout
    }
}
