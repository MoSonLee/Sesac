//
//  WriteViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    override func loadView() {
        // super.loadView XXXXX
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEndOnExit)
    }
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}
