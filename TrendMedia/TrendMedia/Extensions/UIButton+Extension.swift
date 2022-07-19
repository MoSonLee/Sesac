//
//  UIButton+Extension.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

extension UIButton {
    func setButtonLayout() {
        self.setTitle("추가", for: .normal)
        self.tintColor = .black
        self.layer.borderWidth = 1
        self.backgroundColor = .systemGray5
        self.layer.borderColor = UIColor.black.cgColor
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.layer.cornerRadius = 8
    }
}
