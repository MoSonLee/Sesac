//
//  SearchingImageView.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import UIKit

import Kingfisher

final class SearchingImageView: BaseView {
    
    lazy var resultModel: [Result] = []
    private lazy var searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var selectedImage = UIImage()
    var isSelected: Bool = false
    var isSearched: Bool = false
    var totalCount = 0
    var descriptionText: String = ""
    
    override func configureView() {
        self.backgroundColor = .white
        self.addSubview(searchBar)
        self.addSubview(collectionView)
        setSearchBar()
        collectionViewRegisterAndDelegate()
        setCollectionViewLayout()
    }
    
    private func setSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search"
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor)
        ])
        searchBar.delegate = self
    }
    
    private func collectionViewRegisterAndDelegate() {
        collectionView.register(ImageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setCollectionViewLayout() {
        collectionView.collectionViewLayout = setImageCollectionViewLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemIndigo
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: searchBar.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setImageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = ((UIScreen.main.bounds.width) / 3) - spacing
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
}

extension SearchingImageView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearched = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
        APIManager.shared.requestResults(query: searchBar.text!) { resultModel in
            self.resultModel = resultModel
            self.collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
        APIManager.shared.requestResults(query: searchBar.text!) { resultModel in
            self.resultModel = resultModel
            self.collectionView.reloadData()
        }
    }
}

extension SearchingImageView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = .systemIndigo
        let url = URL(string: resultModel[indexPath.row].urls?.raw ?? "")
        cell.searchedImage.kf.setImage(with: url)
        cell.searchedImage.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            selectedImage = cell.searchedImage.image!
            descriptionText = resultModel[indexPath.row].description ?? "no data"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = collectionView.cellForItem(at: indexPath)
        if item?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            item?.backgroundColor = .blue
            
            isSelected = true
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            item?.backgroundColor = nil
            isSelected = false
            return true
        }
        return false
    }
}
