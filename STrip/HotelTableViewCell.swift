//
//  HotelTableViewCell.swift
//  STrip
//
//  Created by Jep Xia on 16/11/29.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelScore: UILabel!
    @IBOutlet weak var hotelLocation: UILabel!
    @IBOutlet weak var hotelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
