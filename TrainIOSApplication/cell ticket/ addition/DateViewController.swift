//
//  DateViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    var delegate: CellTicketViewControllerDelegate?
    
    @IBOutlet weak var datePickerInfo: UIDatePicker!
    var DateInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePickerInfo?.minimumDate = Calendar.current.date(byAdding: .month, value: 0 , to:Date())!
        self.datePickerInfo?.maximumDate = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
    }
    @IBAction func pushButtonSaveDate(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        delegate?.date(date: formatter.string(from: datePickerInfo.date))
        dismiss(animated: true)
    }

}
