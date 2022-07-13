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
            $0.text = "D + Date"
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
    @IBAction private func datePickerValueChanged(_ sender: UIDatePicker) {
        for i in 0..<dayLabelCollection.count {
            dateLabelCollection[i].text =  datePicker.date.description
            dayLabelCollection[i].text = datePicker.date.formatted(date: .complete, time: .shortened)
        }
    }
}
