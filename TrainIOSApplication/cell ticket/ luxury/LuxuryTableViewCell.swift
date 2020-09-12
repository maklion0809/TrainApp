//
//  LuxuryTableViewCell.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 16.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class LuxuryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var railway_carriageLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
