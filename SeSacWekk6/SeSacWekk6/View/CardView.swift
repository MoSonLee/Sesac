//
//  CardView.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

/*
 XIB: Xml Interface Builder
 1. UIView Custom class
 2.File owner ->
 */

/*
 View:
 - 인터페이스 빌더 UI 초기화 구문: required init?
    - 프로토콜 초기화 구문: required -> 초기화 구문이 프로토콜로 명세되어 있음
 -코드 UI 초기화 구문: override init
 */

class CardView: UIView {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
