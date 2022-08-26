//
//  DiaryTableViewCell.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

final class DiaryTableViewCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    lazy var dateLabel = UILabel()
    
    static var identifier: String {
        "DiaryTableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
    }
}
