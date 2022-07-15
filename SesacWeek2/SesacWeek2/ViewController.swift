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
    private var labelName: [String] = ["행복해", "사랑해", "좋아해", "당황해 ", "속상해", "우울해", "심심해", "침울해", "너무슬퍼"]
    private var labelCount: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    private var buttonIndex = 0
    private var labelIndex = 0
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        labelCount = userDefaults.array(forKey: "label") as? [Int] ?? [Int]()
        for a in 0..<labelArray.count {
            labelArray[a].text = "\(labelName[a]) \(labelCount[a])"
            labelArray[a].textAlignment = .center
            labelArray[a].tag = a
            labelArray[a].textColor = .black
        }
        
        super.viewDidLoad()
        buttonArray.forEach {
            $0.setImage(UIImage(named: "sesac_slime\(buttonIndex + 1)")?.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.tag = buttonIndex
            buttonIndex += 1
        }
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        for index in 0..<labelArray.count {
            if sender.tag == index {
                labelArray[sender.tag].text = "\(labelName[sender.tag]) \(labelCount[sender.tag] + 1)"
                labelCount[sender.tag] += 1
            }
        }
        userDefaults.set(labelCount, forKey: "label")
        showAddAlert()
        view.backgroundColor = randomColor()
    }
    
    @IBAction private func initializationButtonTapped(_ sender: UIButton) {
        for index in 0..<labelName.count {
            labelArray[index].text = labelName[index]
            labelCount[index] = 0
        }
        view.backgroundColor = randomColor()
        showInitializeAlert()
    }
    
    private func showAddAlert() {
        let alert =  UIAlertController(title: "추가되었습니다.", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style:.destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func showInitializeAlert() {
        let alert =  UIAlertController(title: "초기화되었습니다.", message: nil, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "확인", style:.destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        for a in 0..<labelCount.count {
            labelCount[a] = 0
        }
        userDefaults.set(labelCount, forKey: "label")
    }
    
    private func randomColor() -> UIColor  {
        let color: [UIColor] = [.yellow, .red, .blue, .brown, .cyan, .orange]
        return color.randomElement()!
    }
}
