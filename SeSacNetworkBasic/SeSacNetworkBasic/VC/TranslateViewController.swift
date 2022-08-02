//
//  TranslateViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIButton, UITextField > Action
//UITextView, UISearchBar, UIPickerView > X
//UIResponderChain > resignFirstResponder() / becomeFirstResponder


class TranslateViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요"
    let translatedTextViewPlaceholderText = "번역된 문장이 여기에 뜹니다!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInputTextView.delegate = self
        translatedTextView.delegate = self
        setViewWithComponents()
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        requestTranslatedData(text: userInputTextView.text)
    }
    
    func requestTranslatedData(text: String) {
        let url = EndPoint.translateURL
        let parameter = ["source": "ko" , "target": "en", "text": text]
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SecretID]
        AF.request(url, method: .post, parameters: parameter ,headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.translatedTextView.text = json["message"]["result"]["translatedText"].stringValue
                print("JSON: \(json)")
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200 {
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setViewWithComponents() {
        userInputTextView.text = textViewPlaceholderText
        translatedTextView.text = translatedTextViewPlaceholderText
        userInputTextView.textColor = .lightGray
        userInputTextView.font = UIFont(name: "TamilSangamMN-Bold", size: 20)
        translatedTextView.textColor = .lightGray
        translatedTextView.font = UIFont(name: "TamilSangamMN-Bold", size: 20)
        translateButton.layer.borderWidth = 1
        translateButton.backgroundColor = .systemBlue
        translateButton.setTitle("번역하기", for: .normal)
        translateButton.tintColor = .white
    }
}

extension TranslateViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    //편집이 시작될 때. 커서가 시작될 때
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    //편집이 끝났을 때, 커서가 없어지는 순간
    //텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자르 보이게해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
