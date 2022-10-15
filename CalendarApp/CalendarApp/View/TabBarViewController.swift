//
//  TabBarViewController.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
//    var diary: [Diary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setupTabBarAppearance()
    }
    
    private func setConfigure() {
        view.backgroundColor = .systemGray
        let firstVC = CalendarViewController()
        firstVC.tabBarItem.title = "캘린더"
        firstVC.tabBarItem.image = UIImage(systemName: "calendar.circle")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
        
        
        let secondVC = WriteViewController()
        secondVC.tabBarItem.title = "일기 작성"
        secondVC.tabBarItem.image = UIImage(systemName: "pencil.circle")
        secondVC.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem.title = "설정"
        thirdVC.tabBarItem.image = UIImage(systemName: "gear.circle")
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "gear.circle.fill")
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemCyan
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
}

