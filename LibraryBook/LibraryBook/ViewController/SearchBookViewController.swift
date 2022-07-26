//
//  BlackNavigationViewController.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/21.
//

import UIKit

class SearchBookViewController: UIViewController {
    
    static var identifier = "SearchBookViewController"
    
    var bookData: Book?
    
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookData?.title
        textfield.placeholder = bookData?.releaseDate
        setLeftNavigationItem()
        setRightNavigationItem()
        view.backgroundColor = randomColorArray.randomElement()
    }
    
    @objc private func viewDismissed() {
        self.dismiss(animated: true)
    }
    @objc func resetButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "LibraryStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchBookViewController") as! SearchBookViewController
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func setLeftNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style:.plain, target: self, action: #selector(viewDismissed))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setRightNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style:.plain, target: self, action: #selector(resetButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
}
