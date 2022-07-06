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

    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.font = .boldSystemFont(ofSize: 20)
        userTextField.keyboardType = .emailAddress

        sendButton.setTitle("전송", for: .normal)
        sendButton.setTitle("빨리 보내", for: .highlighted)
        sendButton.backgroundColor = .yellow
        sendButton.layer.cornerRadius = 8
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.borderWidth = 3
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.blue, for: .highlighted)

        changecolorButton.setTitle("색상 변경", for: .normal)
        changecolorButton.setTitle("빨리 바꿔", for: .highlighted)
        changecolorButton.backgroundColor = .lightGray
        changecolorButton.layer.cornerRadius = 8
        changecolorButton.layer.borderColor = UIColor.black.cgColor
        changecolorButton.layer.borderWidth = 3
        changecolorButton.setTitleColor(.red, for: .normal)
        changecolorButton.setTitleColor(.blue, for: .highlighted)
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
}
