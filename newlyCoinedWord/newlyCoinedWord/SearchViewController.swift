//
//  SearchViewController.swift
//  newlyCoinedWord
//
//  Created by 이승후 on 2022/07/08.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet private var buttonArray: [UIButton]!
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var searchButton: UIButton!
    private var searchedText: WordModel2 = .만반잘부
    private var index = 0
    private var viewModel = WordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.layer.borderWidth = 3
        for i in 0..<buttonArray.count {
            buttonArray[i].titleLabel?.numberOfLines = 2
            buttonArray[i].layer.borderWidth = 2
            buttonArray[i].layer.cornerRadius = 10
            buttonArray[i].titleLabel?.text = textField.text
        }
    }
    // 반복문을 사용하여 구성
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        for i in 0..<viewModel.newWordDictionary.keys.count {
            if textField.text == viewModel.newWordKeys[i] {
                label.text = viewModel.newWordDictionary[textField.text!]
            }
        }
        buttonArray[index%4].setTitle(textField.text, for: .normal)
        index += 1
        if index == 4 {
            index = 0
        }
        view.endEditing(true)
        showAlert()
    }
    //siwtch case문으로 작성 -> 그렇게 효율적이어 보이진 않는다.
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        let searchValue = WordModel2(rawValue: sender.text!)
        switch searchValue {
        case .만반잘부:
            label.text = "만나서 반가워 잘부탁해"
        case .윰차:
            label.text = "유무차별"
        case .꾸안꾸:
            label.text = "꾸민듯 안 꾸밈"
        case .실매:
            label.text = "실시가매니저"
        case .삼귀자:
            label.text = "연애를 시작하기 전 썸 단계!"
        case .할많하않:
            label.text = "할말은 많지만 하지 않는다."
        case .none:
            label.text = "모르는 신조어입니다."
        }
        buttonArray[index%4].setTitle(textField.text, for: .normal)
        index += 1
        if index == 4 {
            index = 0
        }
        showAlert()
        view.endEditing(true)
    }
    //keybord dismiss gesture logic
    @IBAction private func backgroundTapKeybordDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    //alert을 띄워주는 함수 구현
    private func showAlert() {
        let errorAlert =  UIAlertController(title: "검색어를 입력해주세요.", message: nil, preferredStyle: .alert)
        let alert = UIAlertController(title: "검색완료.", message: nil, preferredStyle: .alert)
        //2. button
        let ok = UIAlertAction(title: "확인", style:.destructive, handler: nil)
        //3. 1+2
        errorAlert.addAction(ok)
        alert.addAction(ok)
        
        if textField.text?.isEmpty == true {
            present(errorAlert, animated: true, completion: nil)
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
}
