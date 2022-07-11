//
//  ViewController.swift
//  SesacWeek2
//
//  Created by 이승후 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var buttonArray: [UIButton]!
    
    var imageArray: [UIImage] = []
    var labelName: [String] = ["행복해", "사랑해", "좋아해", "당황해 ", "속상해", "우울해", "심심해", "행복해", "행복해"]
    var buttonTtitle: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    var i = 0
    var j = 0
    var a = 0
    var plus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonArray.forEach {
            $0.setImage(UIImage(named: "sesac_slime\(i + 1)")?.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.setTitle(buttonTtitle[i], for: .normal)
            i += 1
        }
        
        labelArray.forEach {
            $0.text = labelName[j]
            $0.textAlignment = .center
            $0.textColor = .black
            j += 1
        }
    }
    
    //난 행복해만 올라갈래..
    @IBAction func buttonTapped(_ sender: UIButton) {
        plus += 1
        var a = 0
        labelArray[a].text = labelName[a] + String(plus)
        a+=1
    }
}

