//
//  HomeTableViewCell.swift
//  SesacRealm
//
//  Created by 이승후 on 2022/08/22.
//

import UIKit
import RxCocoa
import RxSwift

class HomeTableViewCell: UITableViewCell {
    
    static var identifider: String {
        return "HomeTableViewCell"
    }
    
    var checkButton = UIButton()
    var starButton = UIButton()
    var textlabel = UILabel()
    
    //using code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    //using storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [checkButton, starButton, textlabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            textlabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textlabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 16),
            textlabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            starButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
