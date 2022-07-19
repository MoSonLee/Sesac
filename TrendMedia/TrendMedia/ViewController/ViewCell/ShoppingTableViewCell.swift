//
//  ShoppingTableViewCell.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        self.leftButton = nil
        self.label = nil
        self.rightButton = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
