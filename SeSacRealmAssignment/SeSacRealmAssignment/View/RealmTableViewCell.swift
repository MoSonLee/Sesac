//
//  RealmTableViewCell.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/23.
//

import UIKit

final class RealmTableViewCell: UITableViewCell {
    
    static var identifider: String {
        return "RealmTableViewCell"
    }
    
    lazy var checkButton = UIButton()
    lazy var starButton = UIButton()
    lazy var textlabel = UILabel()
    
    //using code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        reloadInputViews()
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
