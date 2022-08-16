//
//  ThirdViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

final class ThirdViewController: UIViewController {
    
    @IBOutlet weak private var moveToTMDBViewButton: UIButton!
    private var userDefaults = UserDefaults.standard
    
    static var identifier: String {
        "ThirdViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        moveToTMDBViewButton.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateView()
    }
    
    @IBAction private func movetoTMDBButtonTapped(_ sender: UIButton) {
        userDefaults.set("isLaunched", forKey: "InitialLaunched")
        let storyboard = UIStoryboard(name: "TMDB", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: TMDBViewController.identifier) as? TMDBViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    private func animateView() {
        UIView.animate(withDuration: 3) {
            self.moveToTMDBViewButton.frame.size.height += 150
            self.moveToTMDBViewButton.backgroundColor = .systemGray
            self.moveToTMDBViewButton.setTitle("Click move To TMDB!!", for: .normal)
            self.moveToTMDBViewButton.tintColor = .black
            self.view.backgroundColor = .red
        } completion: { _ in }
    }
}
