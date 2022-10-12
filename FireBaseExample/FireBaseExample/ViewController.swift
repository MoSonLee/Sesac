//
//  ViewController.swift
//  FireBaseExample
//
//  Created by 이승후 on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        Analytics.logEvent("testEvent", parameters: [
//          "name": "고래밥",
//          "full_text": "안녕하세요",
//        ])
//
//        Analytics.setDefaultEventParameters([
//          "level_name": "Caverns01",
//          "level_difficulty": 4
//        ])
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController Will Appear")
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        present(ProfileViewController(), animated: true)
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

class ProfileViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Profile ViewController Will Appear")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
    }
}

class SettingViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Setting ViewController Will Appear")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .brown
    }
}

extension UIViewController {
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    //최상위 뷰컨트롤러를 판단해주는 메서드
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
            
        } else {
            return currentViewController
        }
    }
}

extension UIViewController {
    
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard let originMethhod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류 발생")
            return
        }
        
        method_exchangeImplementations(originMethhod, changeMethod)
    }
    
    @objc func changeViewWillAppear() {
        print("Change ViewWillAppear SUCCEED")
    }
}
