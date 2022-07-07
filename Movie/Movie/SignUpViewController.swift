//
//  SignUpViewController.swift
//  Movie
//
//  Created by 이승후 on 2022/07/07.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var recommendCodeTextField: UITextField!
    @IBOutlet weak var SignUpUIButton: UIButton!
    @IBOutlet weak var checkSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendCodeTextField.delegate = self;
        
        IdTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        IdTextField.textAlignment = .center
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        passwordTextField.textAlignment = .center
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        nicknameTextField.textAlignment = .center
        
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        locationTextField.textAlignment = .center
        
        recommendCodeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        recommendCodeTextField.textAlignment = .center
        
        SignUpUIButton.setTitle("회원가입", for: .normal)
        SignUpUIButton.tintColor = .black
        SignUpUIButton.backgroundColor = .white
        SignUpUIButton.layer.cornerRadius = 8
        SignUpUIButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        checkSwitch.setOn(false, animated: true)
        checkSwitch.onTintColor = .red
        checkSwitch.thumbTintColor = .lightGray
        
        IdTextField.backgroundColor = UIColor.lightGray
        passwordTextField.backgroundColor = UIColor.lightGray
        nicknameTextField.backgroundColor = UIColor.lightGray
        locationTextField.backgroundColor = UIColor.lightGray
        recommendCodeTextField.backgroundColor = UIColor.lightGray
        
        IdTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .default
        //        passwordTextField.isSecureTextEntry = true
        nicknameTextField.keyboardType = .alphabet
        locationTextField.keyboardType = .asciiCapable
        recommendCodeTextField.keyboardType = .numberPad
    }
    
    // textfiled에 숫자만 입력되게 하는 로직
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    // ID와 비밀번호 둘 다 입력을 해야 회원가입 성공이 뜨는 로직
    @IBAction func signupbutton(_ sender: Any) {
        view.endEditing(true)
        if IdTextField.text!.count == 0 || passwordTextField.text!.count < 6 {
            SignUpUIButton.setTitle("회원가입 실패", for: .highlighted)
        } else {
            SignUpUIButton.setTitle("회원가입 성공", for: .highlighted)
        }
    }
    
    @IBAction func tapBackGroundGesture(_ sender: Any) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //키보드에서 done or return을 누르면 꺼지는 로직
    @IBAction func done2(_ sender: UITextField) {
        print("exit")
    }
}
