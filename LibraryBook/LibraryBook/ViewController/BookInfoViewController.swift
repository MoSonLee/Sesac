//
//  BookInfoViewController.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/22.
//

import UIKit

class BookInfoViewController: UIViewController {
    static var identifier = "BookInfoViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style:.plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
