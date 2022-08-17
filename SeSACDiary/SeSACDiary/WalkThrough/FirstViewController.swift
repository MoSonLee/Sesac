//
//  FirstViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

final class FirstViewController: UIViewController {
    
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var startImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startImageView.image = UIImage(systemName: "star.fill")
        
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        tutorialLabel.numberOfLines = 0
        blackView.backgroundColor = .black
        blackView.alpha = 0
        
        tutorialLabel.alpha = 0
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        } completion: { _ in
            self.animateBlackView()
            self.animaateImageView()
        }
    }
    
   private func animateBlackView() {
        UIView.animate(withDuration: 2) {
            self.blackView.transform = CGAffineTransform(translationX: -400 , y: 10)
            self.blackView.alpha = 1
            self.blackView.layoutIfNeeded()
        } completion: { _ in }
    }
    
    private func animaateImageView() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.startImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
        }

    }
}
