//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

class RecommandCollectionViewController: UICollectionViewController {
    var image = "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20220620_61%2F1655692158584QeRHN_JPEG%2Fmovie_image.jpg"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 컬렉션 뷰의 셀 크키, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.poasterImageView.backgroundColor = .systemCyan
        let url = URL(string: image)
        cell.poasterImageView.kf.setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 3, position: .center)
        self.navigationController?.popViewController(animated: true)
    }
}
