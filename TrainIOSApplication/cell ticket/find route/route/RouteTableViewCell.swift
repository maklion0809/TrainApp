//
//  RouteTableViewCell.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 22.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var inWayLabel: UILabel!
    @IBOutlet weak var sendLabel: UILabel!
    @IBOutlet weak var parkLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var arrLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
