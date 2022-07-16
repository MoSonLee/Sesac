//
//  ViewController.swift
//  AnniversaryCalculator
//
//  Created by 이승후 on 2022/07/13.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet private var dateLabelCollection: [UILabel]!
    @IBOutlet private var dayLabelCollection: [UILabel]!
    @IBOutlet private var imageCollection: [UIImageView]!
    @IBOutlet weak var initializerButton: UIButton!
    
    private var index = 0
    private var userIndex = 0
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        checkiOSVersion()
        setUserDefaults()
        super.viewDidLoad()
        setButton()
        setDateLabel()
        setDayLabel()
        setImage()
    }
    //datePicker 값이 변했을 때 일어나는 로직
    @IBAction private func datePickerValueChanged(_ sender: UIDatePicker) {
        //DateForamtter: 알아보기 쉬운 날짜 + 시간대 (yyyy MM dd hh:mm:ss)
        let format = DateFormatter()
        format.dateFormat = "yy년 M월 d일"
        imageCollection[index].tag = index
        dateLabelCollection[index].tag = index
        if imageCollection[index].tag == dateLabelCollection[index].tag {
            dateLabelCollection[index].text = dDayDate()
            dayLabelCollection[index].text = format.string(from: datePicker.date)
            userDefaults.set(dateLabelCollection[index].text, forKey: "date\(index)")
            userDefaults.set(dayLabelCollection[index].text, forKey: "day\(index)")
            showAlert("날짜 변경 완효")
            index += 1
            index == 4 ? index = 0 : nil
        }
    }
    
    @IBAction func InitializerButtonTapped(_ sender: UIButton) {
        for index in 0..<dayLabelCollection.count {
            dayLabelCollection[index].text = ""
            dateLabelCollection[index].text = ""
            showAlert("초기화 완료")
            userDefaults.set("", forKey: "date\(index)")
            userDefaults.set("", forKey: "day\(index)")
        }
    }
    
    //alert창 띄워주는 로직
    private func showAlert(_ alertText: String) {
        let alert = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    //dDay Date 구하는 로직 -> 조금 더 효율적이게 작성할 수 없을까?
    private func dDayDate() -> String {
        var dDayDateStringFormed = ""
        let calendar = Calendar.current
        let firstDate = calendar.startOfDay(for: Date())
        let selectedDate = calendar.startOfDay(for: datePicker.date)
        let dDayDate = calendar.dateComponents([.day], from: firstDate, to: selectedDate)
        dDayDateStringFormed =  dDayDate.day! > 0 ? "D + \(String(dDayDate.day!))" :"D \(String(dDayDate.day!))"
        if dDayDate.day! % 100 == 0 {
            let alert = UIAlertController(title: "\(String(describing: dDayDate.day!))일입니다!", message: "축하드립니다!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style:.destructive, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        return dDayDateStringFormed
    }
    
    private func setUserDefaults() {
        for count in 0..<dateLabelCollection.count {
            dateLabelCollection[count].text = userDefaults.string(forKey: "date\(count)")
            dayLabelCollection[count].text = userDefaults.string(forKey: "day\(count)")
        }
    }
    //iOS version에 따라 datePicker 스타일을 다르게 해줌
    private func checkiOSVersion() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    private func setButton() {
        initializerButton.setTitle("초기화 버튼", for: .normal)
        initializerButton.tintColor = .white
        initializerButton.backgroundColor = .systemMint
        initializerButton.layer.cornerRadius = 8
        initializerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setDateLabel() {
        dateLabelCollection.forEach {
            $0.numberOfLines = 1
            $0.textColor = .white
            $0.font = .preferredFont(forTextStyle: .title1)
            $0.font = .boldSystemFont(ofSize: 30)
        }
    }
    
    private func setDayLabel() {
        dayLabelCollection.forEach {
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.font = .preferredFont(forTextStyle: .body)
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .center
        }
    }
    
    private func setImage() {
        for i in 0..<imageCollection.count{
            imageCollection[i].image = UIImage(named: "image\(i+1)")
            imageCollection[i].image?.withRenderingMode(.alwaysOriginal)
            imageCollection[i].contentMode = .scaleAspectFill
            imageCollection[i].clipsToBounds = true
            imageCollection[i].layer.cornerRadius = imageCollection[i].frame.height/2 - 50
        }
    }
}

