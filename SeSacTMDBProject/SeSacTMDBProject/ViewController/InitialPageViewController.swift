//
//  InitialPageViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

final class InitialPageViewController: UIPageViewController {
    
    private lazy var pageViewControllerList: [UIViewController] = []
    static var identifier: String {
        "InitialPageViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        configurePageViewController()
    }
    
    private func createPageViewController() {
        let sb = UIStoryboard(name: "TMDB", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.identifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController .identifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.identifier) as! ThirdViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension InitialPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        
        return index
    }
}
