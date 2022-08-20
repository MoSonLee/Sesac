//
//  SearchingImageViewController.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/20.
//

import UIKit
import Toast

class SearchingImageViewController: BaseViewController {
    
    lazy var imageView = SearchingImageView()
    var completionHandler: ((UIImage) -> ())?
    
    override func loadView() {
        super.view = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        setNavigationItems()
    }
    
    func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func selectButtonTapped() {
        if imageView.isSelected == false {
            self.view.makeToast("사진을 선택해주세요.")
        } else {
            completionHandler?(self.imageView.selectedImage)
            self.dismiss(animated: true,completion: nil)
        }
    }
}
