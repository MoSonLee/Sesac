//
//  FirstViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
   private func animateBlackView() {
        UIView.animate(withDuration: 2) {
            self.blackView.frame.size.width += 250
            self.blackView.alpha = 1
            self.blackView.layoutIfNeeded()
        } completion: { _ in }
    }
}
