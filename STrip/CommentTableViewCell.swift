//
//  CommentTableViewCell.swift
//  STrip
//
//  Created by Jep Xia on 16/11/19.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userPortrait: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
