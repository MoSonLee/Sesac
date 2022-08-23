//
//  SearchImageViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

final class SearchImageViewController: UIViewController {
    
    lazy var resultModel: [Result] = []
    private lazy var searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var selectedImage = UIImage()
    var isSelected: Bool = false
    var isSearched: Bool = false
    
    var completionHandler: ((UIImage) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
        collectionViewRegisterAndDelegate()
    }
    
    private func setConfigure() {
        view.backgroundColor = .white
        
        [searchBar, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = UISearchBar.Style.default
        setNavigationItems()
        collectionView.collectionViewLayout = setImageCollectionViewLayout()
        collectionView.backgroundColor = .systemIndigo
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: searchBar.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        searchBar.delegate = self
    }
    
    private func setImageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = ((UIScreen.main.bounds.width) / 3) - spacing
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func collectionViewRegisterAndDelegate() {
        collectionView.register(ImageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func selectButtonTapped() {
        if isSelected == false {
            self.view.makeToast("사진을 선택해주세요.")
        } else {
            completionHandler?(self.selectedImage)
            self.dismiss(animated: true,completion: nil)
        }
    }
}

extension SearchImageViewController: UISearchBarDelegate {
    
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

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
