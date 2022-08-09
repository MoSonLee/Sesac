//
//  CardView.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/09.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
