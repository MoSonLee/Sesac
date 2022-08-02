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
    private let userDefaults = UserDefaults.standard
    
    var dDayDate: String {
        var dDayDateStringFormed = ""
        let calendar = Calendar.current
        let firstDate = calendar.startOfDay(for: Date())
        let selectedDate = calendar.startOfDay(for: datePicker.date)
        let dDayDate = calendar.dateComponents([.day], from: firstDate, to: selectedDate)
        dDayDateStringFormed =  dDayDate.day! > 0 ? "D + \(String(dDayDate.day!))" :"D \(String(dDayDate.day!))"
        return dDayDateStringFormed
    }
    
    override func viewDidLoad() {
        checkiOSVersion()
        setUserDefaults()
        setIndexUserDefaults()
        super.viewDidLoad()
        setButton()
        setDateLabel()
        setDayLabel()
        setImage()
    }
    
    @IBAction private func datePickerValueChanged(_ sender: UIDatePicker) {
        showAlert("날짜를 변경하시겠습니까?")
    }
    
    @IBAction func InitializerButtonTapped(_ sender: UIButton) {
        for index in 0..<dayLabelCollection.count {
            dayLabelCollection[index].text = ""
            dateLabelCollection[index].text = ""
            showInitializerAlert("초기화 완료")
            userDefaults.set("", forKey: "date\(index)")
            userDefaults.set("", forKey: "day\(index)")
        }
        index = 0
        userDefaults.set(index, forKey: "indexKey")
    }
    
    private func checkiOSVersion() {
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    private func setUserDefaults() {
        for count in 0..<dateLabelCollection.count {
            dateLabelCollection[count].text = userDefaults.string(forKey: "date\(count)")
            dayLabelCollection[count].text = userDefaults.string(forKey: "day\(count)")
        }
    }
    
    private func setIndexUserDefaults() {
        index = userDefaults.integer(forKey: "indexKey")
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
            $0.font = .systemFont(ofSize: 40, weight: .bold)
        }
    }
    
    private func setDayLabel() {
        dayLabelCollection.forEach {
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 20, weight: .bold)
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
    
    private func datePickerChanged() {
        let format = DateFormatter()
        format.dateFormat = "yy년 M월 d일"
        imageCollection[index].tag = index
        dateLabelCollection[index].tag = index
        if imageCollection[index].tag == dateLabelCollection[index].tag {
            dateLabelCollection[index].text = dDayDate
            dayLabelCollection[index].text = format.string(from: datePicker.date)
            userDefaults.set(dateLabelCollection[index].text, forKey: "date\(index)")
            userDefaults.set(dayLabelCollection[index].text, forKey: "day\(index)")
            index += 1
            index == 4 ? index = 0 : nil
        }
        userDefaults.set(index, forKey: "indexKey")
    }
}

extension ViewController {
    func showAlert(_ alertText: String) {
        let alert = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(
            title: "OK",
            style:.destructive,
            handler: {
                (alert: UIAlertAction!) in
                self.datePickerChanged()
                self.dismiss(animated: true, completion: nil)
            })
        let cancel = UIAlertAction(
            title: "cancel",
            style: .destructive,
            handler: nil
        )
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    func showInitializerAlert(_ alertText: String) {
        let alert = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(
            title: "OK",
            style: .destructive,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
