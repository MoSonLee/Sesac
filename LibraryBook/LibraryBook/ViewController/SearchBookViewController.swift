//
//  BlackNavigationViewController.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/21.
//

import UIKit

class SearchBookViewController: UIViewController {
    
    static var identifier = "SearchBookViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftNavigationItem()
        view.backgroundColor = .systemMint
    }
    
    @objc private func viewDismissed() {
        self.dismiss(animated: true)
    }
    
    private func setLeftNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style:.plain, target: self, action: #selector(viewDismissed))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}
