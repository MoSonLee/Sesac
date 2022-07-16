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
        setTextField()
        setButton()
        setCheckSwitch()
    }
    // ID와 비밀번호 둘 다 입력 + 비밀번호 6자 이하 제한해서 회원가입 성공이 뜨는 로직
    @IBAction private func signupbuttonTapped(_ sender: Any) {
        view.endEditing(true)
        if textFieldArray[0].text!.count == 0 {
            showAFailurelert("아이디를 입력해주세요.")
        } else if textFieldArray[1].text!.count < 6 {
            showAFailurelert("비밀번호를 여섯자 이상 입력해주세요.")
        }
        else {
            showASuccesslert("회원가입 성공!")
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
    
    private func showASuccesslert(_ text: String) {
        let alert =  UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { [self]
            UIAlertAction in
            moveToMainView()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAFailurelert(_ text: String) {
        let alert =  UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func setTextField() {
        for index in 0..<textFieldArray.count {
            textFieldArray[index].attributedPlaceholder = NSAttributedString(string: placeholderArray[index], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textFieldArray[index].textAlignment = .center
            textFieldArray[index].backgroundColor = UIColor.darkGray
            textFieldArray[index].keyboardType = keybordTypeArray[index]
            textFieldArray[index].delegate = self
        }
        textFieldArray[1].isSecureTextEntry = true
    }
    
    private func setButton() {
        signUpUIButton.setTitle("회원가입", for: .normal)
        signUpUIButton.tintColor = .black
        signUpUIButton.backgroundColor = .white
        signUpUIButton.layer.cornerRadius = 8
        signUpUIButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setCheckSwitch() {
        checkSwitch.setOn(true, animated: true)
        checkSwitch.onTintColor = .red
        checkSwitch.thumbTintColor = .lightGray
    }
    
    private func moveToMainView() {
        performSegue(withIdentifier: "moveToMainView", sender: nil)
    }
}
