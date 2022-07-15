//
//  TrainsitionSecondViewController.swift
//  newlyCoinedWord
//
//  Created by 이승후 on 2022/07/15.
//

import UIKit

class TrainsitionSecondViewController: UIViewController {
    
    @IBOutlet weak var mottoTextView: UITextView!
    @IBOutlet weak var thisIsLabel: UILabel!
    
    /*
     1. 앱을 켜면 데이터를 가지고 와서 텍스트 뷰에 보여주어야 함.
     2. 바뀐 데이터를 저장해주어야 함.
     => UserDefault (keypath) 형식으로 저장됨
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TransitionSecondViewController", #function)
        thisIsLabel.text = "\(UserDefaults.standard.integer(forKey: "happyEmotion"))"
        if UserDefaults.standard.string(forKey: "key")?.isEmpty == true {
            mottoTextView.text = "입력해주세요."
        } else {
            mottoTextView.text = UserDefaults.standard.string(forKey: "key")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(mottoTextView.text, forKey: "key")
    }
    @IBAction func emotionButtonClicked(_ sender: Any) {
        
        let currentValue = UserDefaults.standard.integer(forKey: "happyEmotion")
        
        let updateValue = currentValue + 1
        UserDefaults.standard.set(updateValue, forKey: "happyEmotion")
        thisIsLabel.text = "\(UserDefaults.standard.integer(forKey: "happyEmotion"))"
        
//        UserDefaults.standard.removeObject(forKey: "happyEmotion")
    }
}
