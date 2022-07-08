//
//  BoardViewController.swift
//  LedBoard
//
//  Created by 이승후 on 2022/07/06.
//

import UIKit

final class BoardViewController: UIViewController {
    
    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var changecolorButton: UIButton!
    @IBOutlet private weak var boardLabel: UILabel!
    @IBOutlet private weak var toggleView: UIView!
    
    @IBOutlet private var buttonList: [UIButton]!
    let labelColor: [UIColor] = [.yellow, .darkGray, .red, .blue, .white]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTextField()
        configureButton(sendButton, buttonTitle: "전송",  HighlightedTitle: "빨리 보내", bgColor: .lightGray)
        configureButton(changecolorButton, buttonTitle: "색상 변경", HighlightedTitle: "빨리 변경해", bgColor: .lightGray)
        
        boardLabel.numberOfLines = 2
        boardLabel.backgroundColor = .clear
        
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.font = .boldSystemFont(ofSize: 20)
        userTextField.keyboardType = .emailAddress
    }
    
    @IBAction private func confirmButtonTapped(_ sender: UIButton) {
        boardLabel.text = userTextField.text
        view.endEditing(true)
    }
    
    @IBAction private func changeColorButtonTapped(_ sender: Any) {
    }
    
    @IBAction private func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction private func viewHidden(_ sender: Any) {
        if toggleView.isHidden {
            toggleView.isHidden = false
        } else {
            toggleView.isHidden = true
        }
    }
    
    @IBAction func changeTextColor(_ sender: UIButton) {
        boardLabel.textColor = labelColor.randomElement()
    }
    @IBAction private func keybordDismiss(_ sender: Any) {}
    
    private func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.keyboardType = .emailAddress
        userTextField.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureButton(_ buttonName: UIButton, buttonTitle: String, HighlightedTitle: String, bgColor: UIColor) {
        buttonName.setTitle(buttonTitle, for: .normal)
        buttonName.setTitle(HighlightedTitle, for: .highlighted)
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.layer.borderWidth = 3
        buttonName.setTitleColor(.black, for: .normal)
        buttonName.setTitleColor(.red, for: .highlighted)
    }
}
