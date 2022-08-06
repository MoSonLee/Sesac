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

final class LottoViewController: UIViewController {
    
    @IBOutlet var lottoNumberLabelArray: [UILabel]!
    @IBOutlet weak var numberTextField: UITextField!
    private lazy var lottopickerView = UIPickerView()
    private lazy var numberList: [Int] = []
    private var A: Int?
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewWithComponentsAndNetwork()
    }
    
    private func requestLotto(number: Int) {
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let date = json["drwNoDate"].stringValue
                self.numberTextField.text = date
                
                for index in 0..<6 {
                    self.lottoNumberLabelArray[index].text = String(json["drwtNo\(index+1)"].intValue)
                    self.lottoNumberLabelArray.last?.text = String(json["bnusNo"].intValue)
                    self.userDefaults.set( self.lottoNumberLabelArray[index].text, forKey: "lotto\(index)\(number)")
                }
                self.userDefaults.set( self.lottoNumberLabelArray.last?.text, forKey: "bonusNo")
                self.userDefaults.set( json["drwNo"].intValue, forKey: "drwNo\(number)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func currentDrwNo() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let firstDate = formatter.date(from: "2002-12-07 21:00")!
        let dateInterval = Calendar.current.dateComponents([.day], from: firstDate, to: Date()).day!
        let currentDrwNo = (dateInterval + 1) / 7
        return currentDrwNo
    }
    
    private func setViewWithComponentsAndNetwork() {
        view.backgroundColor = .systemMint
        numberList = Array(1...currentDrwNo()).reversed()
        numberTextField.inputView = lottopickerView
        lottopickerView.dataSource = self
        lottopickerView.delegate = self
        requestLotto(number: currentDrwNo())
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
        A = self.userDefaults.integer(forKey: "drwNo\(numberList[row])")
        if A != 0 {
            print("network failure")
            for index in 0..<6 {
                lottoNumberLabelArray[index].text = String( UserDefaults.standard.integer(forKey: "lotto\(index)\(numberList[row])"))
                lottoNumberLabelArray.last?.text = String(UserDefaults.standard.integer(forKey: "bonusNo"))
                userDefaults.set( self.lottoNumberLabelArray[index].text, forKey: "lotto\(index)")
            }
        }
        else {
            print("network success")
            requestLotto(number: numberList[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
