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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var list: [imageModel] = []
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self
        searchBar.delegate = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIB
        imageCollectionView.register(UINib(nibName: "ImageSerchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSerchCollectionViewCell")
        imageCollectionView.collectionViewLayout = setImageCollectionViewLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.count)
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSerchCollectionViewCell", for: indexPath) as? ImageSerchCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .clear
        cell.SearchedImage.kf.setImage(with: list[indexPath.row].searchedImageURL)
        return cell
    }
    
    //페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드
    //마지막 셀에 사용자가 위치해있는지 명확하게 확인하기 어려움
    //
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
    //페이지네이션 방법2. UIScrollViewDelegateProtocol.
    //테이블뷰.컬렉션뷰 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음.
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        print(scrollView.contentOffset)
    //    }
    
    
    //fetchImage, requestImage, callRequestImage, getImage...> response에 따라 네이밍을 설정해주기도 함
    func fetchImage(query: String) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)" // 왜 query에 한국어를 넣으면 안 될까?
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SecretID]
        
        AF.request(url, method: .get ,headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.totalCount = json["total"].intValue
                
                for index in json["items"].arrayValue {
                    let imageURL = index["thumbnail"].url
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

//페이지네이션 방법3. 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적
//셀이 화면에 보이기 전에 미리 필요한 리소르를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
//iOS10이, 스크롤 성능 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && list.count < totalCount {
                startPage += 30
                fetchImage(query: searchBar.text!)
            }
        }
        print(list.count)
        print("======\(indexPaths)")
    }
    //취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소======\(indexPaths)")
    }
}

extension UIViewController {
    func setImageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 82
        let width = UIScreen.main.bounds.width / 2 - spacing
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        return layout
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            list.removeAll()
            startPage = 1
//            imageCollectionView.scrollToItem(at:inde, at: .top, animated: true)
            fetchImage(query: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        imageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
