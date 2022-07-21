//
//  UITextField+Extension.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

extension UITextField {
    func borderColor() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8
        self.placeholder = "무엇을 구매하실건가요."
    }
}
