//
//  CalendarViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

import FSCalendar
import SnapKit

class CalendarViewController: UIViewController {
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstriants()
    }
    
    private func configure() {
        view.addSubview(calendar)
    }
    
    private func setConstriants() {
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(600)
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 10
    }
    func  calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return UIImage(systemName: "star.fill")
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return "새싹"
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
