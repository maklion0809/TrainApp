//
//  FindRouteTableViewCell.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 17.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
protocol FindRouteCellDelegate{
    func didTapRain()
}
class FindRouteTableViewCell: UITableViewCell {

    @IBOutlet weak var typeTrainLabel: UILabel!
    @IBOutlet weak var numTrainLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var timeBeginWayLabel: UILabel!
    @IBOutlet weak var timeEndWayLabel: UILabel!
    @IBOutlet weak var availablePlaceLabel: UILabel!
    
    var delegate: FindRouteCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pushRain(_ sender: UIButton) {
        delegate?.didTapRain()
    }

}
