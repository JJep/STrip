//
//  ActivityTableViewCell.swift
//  STrip
//
//  Created by Jep Xia on 16/11/5.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var headPortrait: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var activityText: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
