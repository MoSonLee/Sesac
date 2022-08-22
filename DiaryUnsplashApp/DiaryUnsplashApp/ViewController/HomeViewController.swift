//
//  HomeViewController.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    private lazy var homeView = HomeView()
    let localRealm = try! Realm() //Realm 테이블에 데이터를 CRUD할 때 realm 테이블 경로에 접근
    
    override func loadView() {
        super.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        homeView.moveToImageViewButton.addTarget(self, action: #selector(moveToImageViewButtonTapped), for: .touchUpInside)
    }
    
    @objc private func moveToImageViewButtonTapped(_ moveButton: UIButton) {
//        self.dismiss(animated: true)
//        let vc = SearchingImageViewController()
//        vc.completionHandler = { image, description in
//            self.homeView.homeImageView.image = image
//            self.homeView.descriptionTextView.text = description
//        }
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        nav.modalTransitionStyle = .flipHorizontal
//        self.present(nav, animated: true)
        let task = userDiary(diaryTitle: "오늘의 일기\(Int.random(in: 1...1000))", diaryContent: "일기 테스트 내용", diaryDate: Date(), diaryRegisterDate: Date(), photo: nil) // Recodrd
        try! localRealm.write{
            localRealm.add(task)
            print("realm Succeeded")
            self.dismiss(animated: true)
        }
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true)
    }
}

