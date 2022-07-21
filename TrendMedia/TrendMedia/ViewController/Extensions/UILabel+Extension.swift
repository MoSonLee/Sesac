//
//  UILabel+Extension.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

extension UILabel {
    func setTitleLabel() {
        self.font = .preferredFont(forTextStyle: .title1, compatibleWith: .current)
    }
    
    func setDateLabel() {
        self.font = .preferredFont(forTextStyle: .body, compatibleWith: .current)
    }
    
    func setDescriptionLabel() {
        self.font = .preferredFont(forTextStyle: .caption1, compatibleWith: .current)
        self.numberOfLines = 5
        self.sizeToFit()
    }
}
