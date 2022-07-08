//
//  SignUpViewController.swift
//  Movie
//
//  Created by 이승후 on 2022/07/07.
//

import UIKit

final class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private var textFieldArray: [UITextField]!
    @IBOutlet private weak var signUpUIButton: UIButton!
    @IBOutlet private weak var checkSwitch: UISwitch!
    
    private let placeholderArray = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천코드"]
    private let keybordTypeArray: [UIKeyboardType] = [.emailAddress, .default, .alphabet, .asciiCapable, .numberPad]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0..<textFieldArray.count {
            textFieldArray[index].attributedPlaceholder = NSAttributedString(string: placeholderArray[index], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textFieldArray[index].textAlignment = .center
            textFieldArray[index].backgroundColor = UIColor.darkGray
            textFieldArray[index].keyboardType = keybordTypeArray[index]
            textFieldArray[index].delegate = self
        }
        textFieldArray[1].isSecureTextEntry = true
        
        signUpUIButton.setTitle("회원가입", for: .normal)
        signUpUIButton.tintColor = .black
        signUpUIButton.backgroundColor = .white
        signUpUIButton.layer.cornerRadius = 8
        signUpUIButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        checkSwitch.setOn(true, animated: true)
        checkSwitch.onTintColor = .red
        checkSwitch.thumbTintColor = .lightGray
    }
    // ID와 비밀번호 둘 다 입력 + 비밀번호 6자 이하 제한해서 회원가입 성공이 뜨는 로직
    @IBAction private func signupbuttonTapped(_ sender: Any) {
        view.endEditing(true)
        if textFieldArray[0].text!.count == 0 || textFieldArray[1].text!.count < 6 {
            signUpUIButton.setTitle("회원가입 실패", for: .highlighted)
        } else {
            signUpUIButton.setTitle("회원가입 성공", for: .highlighted)
        }
    }
    //background tap 했을 때 키보드 내려가는 로직
    @IBAction private func tapBackGroundGesture(_ sender: Any) {
        view.endEditing(true)
    }
    //키보드에서 done or return을 누르면 꺼지는 로직
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    // 추천코드입력 textField에 숫자만 입력되게 하는 로직
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 4 {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string))
            else {
                return false
            }
        }
        return true
    }
}
