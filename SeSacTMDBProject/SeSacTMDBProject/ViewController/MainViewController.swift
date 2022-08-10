//
//  MainViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var mainTableView: UITableView!
    
    private var movieEposiodeList: [[String]] = []
    private var titleList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        getRecommandTMDB()
    }
    
    private func getRecommandTMDB() {
        APIManager.shared.requestImage { value in
            self.movieEposiodeList = value
            self.mainTableView.reloadData()
            dump(self.movieEposiodeList)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        movieEposiodeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .systemCyan
        cell.mainCollectionView.backgroundColor = .purple
        cell.mainCollectionView.delegate = self
        cell.mainCollectionView.dataSource = self
        cell.mainCollectionView.tag = indexPath.section
        cell.mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        cell.mainCollectionView.reloadData()
        cell.mainTitleLabel.text = APIManager.shared.tvList[indexPath.section].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieEposiodeList[collectionView.tag].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let url = URL(string: "\(APIManager.shared.imageURL)\(movieEposiodeList[collectionView.tag][indexPath.item])")
        cell.cardView.cardImageView.kf.setImage(with: url)
        cell.cardView.cardImageView.contentMode = .scaleToFill
        return cell
    }
}
