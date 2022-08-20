//
//  HomeViewController.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var homeView = HomeView()
    
    override func loadView() {
        super.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        homeView.moveToImageViewButton.addTarget(self, action: #selector(moveToImageViewButtonTapped), for: .touchUpInside)
    }
    
    @objc private func moveToImageViewButtonTapped(_ moveButton: UIButton) {
        self.dismiss(animated: true)
        let vc = SearchingImageViewController()
        vc.imageCompletionHandler = { value in
            self.homeView.homeImageView.image = value
        }
        vc.descriptionComPletionHandler = { value in
            self.homeView.descriptionTextView.text = value
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true)
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
}
