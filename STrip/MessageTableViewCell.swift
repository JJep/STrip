//
//  MessageTableViewCell.swift
//  STrip
//
//  Created by Jep Xia on 16/10/18.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置cell是有圆角边框显示
        customView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
