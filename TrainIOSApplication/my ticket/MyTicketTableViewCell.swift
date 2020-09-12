//
//  MyTicketTableViewCell.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 22.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
protocol DeleteTicketHistory{
    func didTapDelete()
}
class MyTicketTableViewCell: UITableViewCell {

    var delegate: DeleteTicketHistory?
    
    @IBAction func pushDeleteButton(_ sender: UIButton) {
        delegate?.didTapDelete()
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var numTrainLabel: UILabel!
    @IBOutlet weak var numTicketLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var dataSendLabel: UILabel!
    @IBOutlet weak var infoPlaceLabel: UILabel!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
