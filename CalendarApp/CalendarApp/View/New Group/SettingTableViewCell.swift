//
//  SettingTableViewCell.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/26.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    
    lazy var textTitleLabel = UILabel()
    
    static var identifier: String {
        "SettingTableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(textTitleLabel)
        
        textTitleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
    }
}
