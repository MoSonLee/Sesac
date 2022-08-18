//
//  UIViewcontroller+Extension.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/18.
//

import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storybord: String, viewController vc: T) {
        let sb = UIStoryboard(name: storybord, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: String(describing: vc)) as? T else { return }
        self.present(controller, animated: true)
    }
}
