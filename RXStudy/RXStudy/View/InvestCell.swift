//
//  InvestCell.swift
//  RXStudy
//
//  Created by 이승후 on 2022/08/21.
//

import UIKit

import SnapKit

final class InvestCell: UITableViewCell {
    
    static var identifider: String {
        return "InvestCell"
    }
    
    private let nameLabel = UILabel()
    private let accountLabel = UILabel()
    private let currencyLabel = UILabel()
    private let evaluationLabel = UILabel()
    private let badgeLabel = UILabel()
    
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
        [nameLabel, accountLabel, currencyLabel, evaluationLabel, badgeLabel].forEach {
            contentView.addSubview($0)
        }
        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalTo(badgeLabel.snp.left).offset(-20)
            make.height.equalTo(22)
        }
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(badgeLabel.snp.left).offset(-20)
            make.height.equalTo(18)
        }
        evaluationLabel.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(24)
        }
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
     func configure(account: Account) {
        nameLabel.text = account.name
        accountLabel.text = account.numberFormat
        evaluationLabel.text = "\(account.evaluation)원"
        badgeLabel.text = account.badge
    }
}
