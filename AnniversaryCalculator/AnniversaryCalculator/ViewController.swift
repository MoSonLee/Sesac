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
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        dateLabelCollection.forEach {
            $0.numberOfLines = 1
            $0.textColor = .white
            $0.font = .preferredFont(forTextStyle: .title1)
            $0.font = .boldSystemFont(ofSize: 30)
            $0.text = "D + 0"
        }
        
        dayLabelCollection.forEach{
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.font = .preferredFont(forTextStyle: .body)
            $0.font = .systemFont(ofSize: 20)
            $0.text = "day"
            $0.textAlignment = .center
        }
        
        for i in 0..<imageCollection.count{
            imageCollection[i].image = UIImage(named: "image\(i+1)")
            imageCollection[i].image?.withRenderingMode(.alwaysOriginal)
            imageCollection[i].contentMode = .scaleAspectFill
            imageCollection[i].clipsToBounds = true
            imageCollection[i].layer.cornerRadius = imageCollection[i].frame.height/2 - 50
        }
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
            showAlert()
            index += 1
            index == 4 ? index = 0 : nil
        }
    }
    //alert창 띄워주는 로직
    private func showAlert() {
        let alert = UIAlertController(title: "날짜 변경 완료", message: nil, preferredStyle: .alert)
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
}