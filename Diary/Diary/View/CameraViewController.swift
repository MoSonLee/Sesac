//
//  CameraViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

final class CameraViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setConstraints()
    }
    
    private func setConfigure() {
        view.backgroundColor = .systemGray
        setNavigationItems()
    }
    
    private func setConstraints() {
        
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
