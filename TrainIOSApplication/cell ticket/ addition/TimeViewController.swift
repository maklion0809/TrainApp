//
//  TimeViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    var delegate: CellTicketViewControllerDelegate?
    
    var currentDate: String?
    
    @IBOutlet weak var TimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatterDate = DateFormatter()
               formatterDate.dateFormat = "yyyy-MM-dd"
               formatterDate.locale = Locale.current
        if(formatterDate.string(from: Date()) == currentDate!){
            self.TimePicker.minimumDate = Calendar.current.date(byAdding: .month, value: 0 , to:Date())!
        }
    }
    @IBAction func pushTimeButton(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        delegate?.time(time: formatter.string(from: TimePicker.date))
        dismiss(animated: true)
    }
    
}
