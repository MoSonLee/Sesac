//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .systemMint
    }
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert =  UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: alertMessage, style:.destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
