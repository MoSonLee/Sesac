//
//  TMDBViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/03.
//

import UIKit

class TMDBViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var TMDBCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        TMDBCollectionView.register(UINib(nibName: "TMDBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TMDBCollectionViewCell")
        TMDBCollectionView.collectionViewLayout = setTMDBCollectionViewLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TMDBCollectionViewCell", for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .systemGray
        return cell
    }
}

extension UIViewController {
    func setTMDBCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
}
