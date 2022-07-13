//
//  ViewController.swift
//  SesacWeek2
//
//  Created by 이승후 on 2022/07/11.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private var labelArray: [UILabel]!
    @IBOutlet private var buttonArray: [UIButton]!
    
    private var imageArray: [UIImage] = []
    private var labelName: [String] = ["행복해", "사랑해", "좋아해", "당황해 ", "속상해", "우울해", "심심해", "행복해", "행복해"]
    private var labelCount: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    private var i = 0
    private var j = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonArray.forEach {
            $0.setImage(UIImage(named: "sesac_slime\(i + 1)")?.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.tag = i
            i += 1
        }
        
        labelArray.forEach {
            $0.text = labelName[j]
            $0.textAlignment = .center
            $0.textColor = .black
            $0.tag = j
            j += 1
        }
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        for index in sender.tag..<9 {
            switch sender.tag {
            case labelArray[index].tag:
                button(sender, labelArray[index])
            default:
                break
            }
        }
        showAlertController()
    }
    
    @IBAction private func initializationButtonTapped(_ sender: UIButton) {
        for index in 0..<labelName.count {
            labelArray[index].text = labelName[index]
            labelCount[index] = 0
        }
        view.backgroundColor = randomColor()
    }
    
    //함수 인자에 UIButton 등 클래스를 넣어주면 안됨 -> 수정 예정
    private func button(_ sender: UIButton, _ sender2: UILabel)  {
        labelCount[sender2.tag] += 1
        if sender.tag == sender2.tag {
            sender2.text = labelName[sender2.tag] + String(labelCount[sender2.tag])
        }
    }
    
    private func showAlertController() {
        //1. 흰 바탕: UIAlertController
        let alert =  UIAlertController(title: "추가되었습니다.", message: nil, preferredStyle: .alert)
        
        //2. button
        let ok = UIAlertAction(title: "확인", style:.destructive, handler: nil)
        
        //3. 1+2
        alert.addAction(ok)
        
        //4. present
        present(alert, animated: true, completion: nil)
        view.backgroundColor = randomColor()
    }
    
    private func randomColor() -> UIColor  {
        let color: [UIColor] = [.yellow, .red, .blue, .brown]
        return color.randomElement()!
    }
}
