//
//  BoardViewController.swift
//  LedBoard
//
//  Created by 이승후 on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var changecolorButton: UIButton!
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var toggleView: UIView!
    
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTextField()
        designButton(sendButton, buttonTitle: "전송",  HighlightedTitle: "빨리 보내", bgColor: .lightGray)
        designButton(changecolorButton, buttonTitle: "색상 변경", HighlightedTitle: "빨리 변경해", bgColor: .lightGray)
        
        boardLabel.numberOfLines = 0
        boardLabel.backgroundColor = .clear
        
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.font = .boldSystemFont(ofSize: 20)
        userTextField.keyboardType = .emailAddress
        
        // 1. 반복문
        //        let buttonArray: [UIButton] = [sendButton, changecolorButton]
        //
        //        for item in buttonArray {
        //            item.backgroundColor = .yellow
        //            item.layer.cornerRadius = 2
        //        }
        
        //아웃렛 컬렉션
        //        for item in buttonList {
        //            item.backgroundColor = .blue
        //            item.layer.cornerRadius = 2
        //        }
    }
    
    func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.keyboardType = .emailAddress
        userTextField.font = .boldSystemFont(ofSize: 20)
    }
    
    func designButton(_ buttonName: UIButton, buttonTitle: String, HighlightedTitle: String, bgColor: UIColor) {
        buttonName.setTitle(buttonTitle, for: .normal)
        buttonName.setTitle(HighlightedTitle, for: .highlighted)
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.layer.borderWidth = 3
        buttonName.setTitleColor(.black, for: .normal)
        buttonName.setTitleColor(.red, for: .highlighted)
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        boardLabel.text = userTextField.text
        view.endEditing(true)
    }
    
    @IBAction func changeColorButtonTapped(_ sender: Any) {
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func viewHidden(_ sender: Any) {
        if toggleView.isHidden {
            toggleView.isHidden = false
        } else {
            toggleView.isHidden = true
        }
    }
    
    @IBAction func keybordDismiss(_ sender: Any) {
        
    }
}
