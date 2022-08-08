//
//  ClosureViewController.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        showAlert(title: "컬러피커를 띄우겠습니까?", message: "", okTitle: "띄우기") {
            let picker = UIColorPickerViewController()
            self.present(picker, animated:  true)
            
        }
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기") {
            self.view.backgroundColor = .systemGray
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
            okAction()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
