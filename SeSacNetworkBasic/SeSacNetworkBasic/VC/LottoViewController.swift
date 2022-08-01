//
//  LottoViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/28.
//
//    @IBOutlet weak var lottopickerView: UIPickerView!

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet var lottoNumberLabelArray: [UILabel]!
    @IBOutlet weak var numberTextField: UITextField!
    
    private var lottopickerView = UIPickerView()
    private let numberList: [Int] = Array(1...1026).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        lottopickerView.dataSource = self
        lottopickerView.delegate = self
        numberTextField.inputView = lottopickerView
        requestLotto(number: numberList.count)
        numberTextField.layer.borderWidth = 1
    }
    
    private func requestLotto(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let date = json["drwNoDate"].stringValue
                for index in 0..<6 {
                    self.lottoNumberLabelArray[index].text = String(json["drwtNo\(index+1)"].intValue)
                    self.lottoNumberLabelArray[index].layer.borderWidth = 1
                }
                self.lottoNumberLabelArray.last?.text = String(json["bnusNo"].intValue)
                self.lottoNumberLabelArray.last?.layer.borderWidth = 1
                self.numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
