//
//  SecondViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

final class SecondViewController: UIViewController {
    
    @IBOutlet private weak var SecondPageViewLabel: UILabel!
    
    static var identifier: String {
        "SecondViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SecondPageViewLabel.text = "Wait"
        view.backgroundColor = .systemMint
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateView()
    }
    
    private func animateView() {
        UIView.animate(withDuration: 2) {
            self.SecondPageViewLabel.frame.size.height += 150
            self.SecondPageViewLabel.backgroundColor = .systemCyan
            self.SecondPageViewLabel.text = "Surprise"
        } completion: { _ in }
    }
}
