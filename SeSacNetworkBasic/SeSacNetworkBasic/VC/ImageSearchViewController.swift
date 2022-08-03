//
//  ImageSearchViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var list: [imageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIB
        imageCollectionView.register(UINib(nibName: "ImageSerchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSerchCollectionViewCell")
        imageCollectionView.collectionViewLayout = setImageCollectionViewLayout()
        fetchImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.count)
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSerchCollectionViewCell", for: indexPath) as? ImageSerchCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .clear
        cell.SearchedImage.kf.setImage(with: list[indexPath.row].searchedImageURL!)
        return cell
    }
    
    //fetchImage, requestImage, callRequestImage, getImage...> response에 따라 네이밍을 설정해주기도 함
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31" // 왜 query에 한국어를 넣으면 안 될까?
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SecretID]
        AF.request(url, method: .get ,headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0...5 {
                    let imageURL = json["items"][index]["thumbnail"].url
                    let data = imageModel(searchedImageURL: imageURL)
                    self.list.append(data)
                }
                print("JSON: \(json)")
                self.imageCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UIViewController {
    func setImageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        return layout
    }
}
