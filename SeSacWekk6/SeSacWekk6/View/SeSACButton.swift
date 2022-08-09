//
//  SeSACButton.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

/*
 Swift Attribute(속성)
 @IBInspectable, @IBDesignable, @objc, @escaping, @available, @discardbleResult, etc
 */

//빌드시 확인 할 수 있음
@IBDesignable
class SeSACButton: UIButton {
    //인터페이스 빌더 인스펙터 영역에서 show
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
