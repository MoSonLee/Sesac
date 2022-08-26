//
//  RealmTableViewCell.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/27.
//

import UIKit

import SnapKit

final class RealmTableViewCell: UITableViewCell {
    
    lazy var realmImage = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    
    static var identifier: String {
        "RealmTableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [realmImage, titleLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        realmImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(realmImage.snp.right).offset(16)
            make.height.equalTo(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(realmImage.snp.right).offset(16)
            make.bottom.equalToSuperview().offset(16)
        }
    }
}

