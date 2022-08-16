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


final class TMDBViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    static var identifier: String {
        "TMDBViewController"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var userDefaults = UserDefaults.standard
    
    private lazy var hud = JGProgressHUD()
    private lazy var list: [TMDBModel] = []
    private lazy var movieNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set("isLaunched", forKey: "InitialLaunched")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TMDBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TMDBCollectionViewCell")
        setNavigationItems()
        collectionView.collectionViewLayout = setTMDBCollectionViewLayout()
        requestTMDB()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TMDB", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else { return }
        vc.model = list[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(model: list[indexPath.row])
        cell.configureShadow()
        cell.movieButtonPressed = { [weak self] in
            guard let self = self else { return }
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { return }
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
        APIManager.shared.requestTMDB { [weak self] list, errorCode  in
            guard let self = self else { return }
            if errorCode != nil {
                self.hud.dismiss(animated: true)
                return
            }
            self.list = list!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.hud.dismiss(animated: true)
            }
        }
    }
}

extension TMDBViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = collectionView.contentSize.height
        let pagination_y = collectionViewContentSize * 0.8
        if contentOffset_y > pagination_y {
            requestTMDB()
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

