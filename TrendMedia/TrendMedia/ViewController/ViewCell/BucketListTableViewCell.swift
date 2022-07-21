//
//  BucketListTableViewCell.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {
    
    static let identifier = "BucketListTableViewCell"
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
