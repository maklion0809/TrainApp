//
//  CellTicketViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

protocol CellTicketViewControllerDelegate {
    func update(text: String, num: Int)
    func date(date: String)
    func time(time: String)
}
class CellTicketViewController: UIViewController, CellTicketViewControllerDelegate{

    let numRowCellTicket: Int = 2
    
    let transiton = SlideInTransition()

    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    
    @IBOutlet weak var TextFrom: UITextField!
    @IBOutlet weak var TextTo: UITextField!
    
    //дата
    
    @IBOutlet weak var FindRouteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // дизайн кнопки
       FindRouteButton.layer.cornerRadius = 24
        dateText.layer.borderWidth = 2
        dateText.layer.borderColor = UIColor.white.cgColor
        timeText.layer.borderWidth = 2
        timeText.layer.borderColor = UIColor.white.cgColor
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm"
        formatterTime.locale =  Locale(identifier: "ru_RU")
        timeText.text = formatterTime.string(from: Date()) + ":00"
        TextFrom.layer.borderWidth = 2
        TextFrom.layer.borderColor = UIColor.white.cgColor
        TextFrom.font = .systemFont(ofSize: 20)
        TextTo.layer.borderWidth = 2
        TextTo.layer.borderColor = UIColor.white.cgColor
        TextTo.font = .systemFont(ofSize: 20)
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        formatterDate.locale = Locale.current
        dateText.text = formatterDate.string(from: Date())
    }
    
    
    @IBAction func pushButtonDate(_ sender: UIButton) {
    let sb = storyboard?.instantiateViewController(identifier: "DateVC") as! DateViewController
        sb.modalPresentationStyle = .fullScreen
        sb.delegate = self
        self.present(sb, animated: true, completion: nil)
    }
    // время
    
    
    @IBAction func pushButtonTime(_ sender: UIButton) {
    let sb = storyboard?.instantiateViewController(identifier: "TimeVC") as! TimeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.currentDate = dateText.text
        sb.delegate = self
        self.present(sb, animated: true, completion: nil)
    }
    //Поиск
    
    @IBAction func pushButtonSearch(_ sender: UIButton) {
    let sb = storyboard?.instantiateViewController(identifier: "SearchVC") as! SearchStationViewController
        sb.num = 1
        sb.delegate = self
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func pushButtonSearch1(_ sender: UIButton) {
    let sb = storyboard?.instantiateViewController(identifier: "SearchVC") as! SearchStationViewController
        sb.num = 2
        sb.delegate = self
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
    
    func update(text: String, num: Int) {
        if(num == 1){
            TextFrom.text = text
        }else{
            TextTo.text = text
        }
    }
    func date(date: String) {
        dateText.text = date
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        formatterDate.locale = Locale.current
        let currentDate = formatterDate.string(from: Date())
        if(dateText.text == currentDate){
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = "HH:mm"
            formatterTime.locale =  Locale(identifier: "ru_RU")
            timeText.text = formatterTime.string(from: Date()) + ":00"
        }
     }
    func time(time: String){
       timeText.text = time
    }
    
    // города Харьков, Львов, Киев From
    
    @IBAction func pushFromKharkiv(_ sender: UIButton) {
        TextFrom.text = "Харьков"
    }
    
    @IBAction func pushFromKiev(_ sender: UIButton) {
        TextFrom.text = "Киев"
    }
    
    @IBAction func pushFromLvov(_ sender: UIButton) {
        TextFrom.text = "Львов"
    }
    // города Харьков, Львов, Киев To
    
    @IBAction func pushToKharkiv(_ sender: UIButton) {
        TextTo.text = "Харьков"
    }
    
    @IBAction func pushToKiev(_ sender: UIButton) {
        TextTo.text = "Киев"
    }
    
    @IBAction func pushToLvov(_ sender: UIButton) {
        TextTo.text = "Львов"
    }
    
    @IBAction func pushChangeCity(_ sender: UIButton) {
        if TextFrom.text != TextTo.text{
            let st = TextFrom.text
            TextFrom.text = TextTo.text
            TextTo.text = st
        }
    }
    
    @IBAction func pushFindRoute(_ sender: UIButton) {
        let station_begin = TextFrom.text
        let station_end = TextTo.text
        let date = dateText.text
        let time = timeText.text
        if(!station_begin!.isEmpty && !station_end!.isEmpty && !date!.isEmpty && !time!.isEmpty){
            if(station_end != station_begin){
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                let sb = storyboard?.instantiateViewController(identifier: "FindRouteViewController") as! FindRouteViewController
                sb.stationBegin = TextFrom.text!
                sb.stationEnd = TextTo.text!
                sb.date = dateText.text!
                sb.time = timeText.text!
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: false)
            }else{
                let alert = UIAlertController(title: "Ошибка!", message: "Направления совпадают.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Ошибка!", message: "Заполните все поля.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
    guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = numRowCellTicket
        present(menuViewController, animated: true)
    }
    
    
    
}
// меню
extension CellTicketViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
