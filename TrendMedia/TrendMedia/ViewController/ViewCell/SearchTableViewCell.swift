//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
