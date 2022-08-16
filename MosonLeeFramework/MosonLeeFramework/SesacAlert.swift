//
//  SesacAlert.swift
//  MosonLeeFramework
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    open func testOpen() {}
    
    public func showSesacAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping ((UIAlertAction) -> Void)) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style:.destructive, handler: buttonAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    internal func testInternal() {}
    
    fileprivate func textFilePrivate() {}
    
    private func textrivate() {} 
}
