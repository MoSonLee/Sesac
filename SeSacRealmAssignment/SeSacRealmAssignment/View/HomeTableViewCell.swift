//
//  HomeTableViewCell.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static var identifider: String {
        return "HomeTableViewCell"
    }
    
    lazy var checkButton = UIButton()
    lazy var starButton = UIButton()
    lazy var textlabel = UILabel()
    
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
            checkButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            checkButton.trailingAnchor.constraint(equalTo: self.textlabel.leadingAnchor, constant:  -16),
            
            textlabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textlabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            textlabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            starButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(tableModel: TableModel) {
        self.textlabel.text = tableModel.labelText
        self.textlabel.textAlignment = .center
        self.starButton.setImage(UIImage(systemName: tableModel.starButtonString), for: .normal)
        self.checkButton.setImage(UIImage(systemName: tableModel.checkButtonString), for: .normal)
    }
}
