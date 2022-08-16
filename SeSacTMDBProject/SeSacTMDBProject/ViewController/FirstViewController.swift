//
//  FirstViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

final class FirstViewController: UIViewController {
    
    @IBOutlet private var firstImageViewCollection: [UIImageView]!
    @IBOutlet private weak var firstViewLabel: UILabel!
    
    static var identifier: String {
        "FirstViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        animateBlackView()
        for index in 0..<firstImageViewCollection.count {
            setImage(index: index)
        }
        setLabel()
    }
    
    private func setImage(index: Int) {
        firstImageViewCollection[index].tag = index
        firstImageViewCollection[index].image = UIImage(named: "PreyImage\(index+1)")
        firstImageViewCollection[index].contentMode = .scaleAspectFill
    }
    
    private func setLabel() {
        firstViewLabel.text = "This is TMDB APP"
        firstViewLabel.textAlignment = .center
        firstViewLabel.backgroundColor = .systemCyan
        firstViewLabel.layer.cornerRadius = 15
        firstViewLabel.layer.borderWidth = 1
        firstViewLabel.alpha = 05
        firstViewLabel.layer.borderColor = UIColor(red: 100, green: 100, blue: 100, alpha: 1).cgColor
    }
    
    private func animateBlackView() {
        UIView.animate(withDuration: 5) {
            for index in 0..<self.firstImageViewCollection.count {
                self.firstImageViewCollection[index].frame.size.width -= 250
                self.firstImageViewCollection[index].alpha = 0
                self.firstImageViewCollection[index].layoutIfNeeded()
            }
            UIView.animate(withDuration: 2) {
                self.firstViewLabel.frame.size.height += 250
                self.firstViewLabel.alpha = 1
            }
        } completion: { _ in }
    }
}
