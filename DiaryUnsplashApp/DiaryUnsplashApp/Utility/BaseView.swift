//
//  BaseView.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
}
