//
//  SearchImageViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

import JGProgressHUD
import Realm
import RealmSwift

final class SearchImageViewController: UIViewController {
    
    var delegate: SelectImageDelegate?
    
    private lazy var searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private lazy var hud = JGProgressHUD()
    
    var resultModel: [Result] = []
    var selectedImage = UIImage()
    var isSearched: Bool = false
    var completionHandler: ((UIImage) -> ())?
    var count = 0
    var selectIndexPath: IndexPath?
    
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
       
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(selectButtonTapped))
        self.navigationItem.rightBarButtonItems = [saveButton]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        saveButton.tintColor = .red
    }
    
    private func collectionViewRegisterAndDelegate() {
        collectionView.register(ImageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
//        private func saveButton(fileName: String, image: UIImage) {
//            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//            let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로, 이미지를 저장할 위치
//            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
//
//            do {
//                try data.write(to: fileURL)
//            } catch let error {
//                print("file save error", error)
//            }
//        }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    //using closure
    //    @objc private func selectButtonTapped() {
    //        if isSelected == false {
    //            self.view.makeToast("사진을 선택해주세요.")
    //        } else {
    //            completionHandler?(self.selectedImage)
    //            self.dismiss(animated: true,completion: nil)
    //        }
    //    }
    
    //using protocol
    @objc private func selectButtonTapped() {
        if count == 0 {
            self.view.makeToast("사진을 선택해주세요")
        } else {
            delegate?.sendImageData(image: selectedImage)
            self.dismiss(animated: true,completion: nil)
        }
    }
    
//        @objc private func saveButtonTapped() {
//            let task = UserDiary(diaryTitle: "", diaryContent: "", diaryRegisterDate: Date(), photo: nil)
//    
//            do {
//                try localRealm.write {
//                    localRealm.add(task)
//                }
//            }
//            catch let error {
//                print((error))
//            }
//            let image = selectedImage
//            saveButton(fileName: "\(task.objectId)", image: image)
//            dismiss(animated: true)
//        }
    
        
}

extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearched = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
        hud.show(in: self.view, animated: true)
        APIManager.shared.requestResults(query: searchBar.text!) { resultModel in
            self.resultModel = resultModel
            self.collectionView.reloadData()
        }
        hud.dismiss(animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearched = false
        hud.show(in: self.view, animated: true)
        APIManager.shared.requestResults(query: searchBar.text!) { resultModel in
            self.resultModel = resultModel
            self.collectionView.reloadData()
        }
        hud.dismiss(animated: true)
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
        
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            selectedImage = cell.searchedImage.image!
            selectIndexPath = indexPath
            count += 1
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectIndexPath = nil
        collectionView.reloadData()
    }
}
