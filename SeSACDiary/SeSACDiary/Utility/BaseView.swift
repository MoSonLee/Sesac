//
//  BaseView.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    func configureUI() { }
    
    func setConstraints() { }
}


class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "apple")
    }
}

let a = Apple(wwdc: "애플")
