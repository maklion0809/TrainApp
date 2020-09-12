//
//  FindRouteViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 19.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
struct CellData{
    var opened: Bool
    var tr_id: Int
    var typeTrain: String
    var numTrain: String
    var km: Int
    var fl_id: Int
    var direction: String
    var timeBeginWay: String
    var timeEndWay: String
    var availablePlace: String
    var sectionTypeRailway_carriage: [String]
    var sectionCountPlace: [String]
    var countVagon: [Int]
}
class FindRouteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FindRouteCellDelegate {
    
    //передача данных сюда
    var stationBegin: String = ""
    var stationEnd: String = ""
    var time: String = ""
    var date: String = ""
    // проперти для данных с сервера
    var allVagon: [AllVagonFlight]?
    var allPlace: Int = 0
    
    @IBOutlet weak var viewTable: UITableView!
    
    var tableViewData = [CellData]()
    
    let networkService = NetworkService()
    
    var numRoute: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://localhost:3000/api/getRoute?from=\(stationBegin)&to=\(stationEnd)&date=\(date)&time=\(time)"
        networkService.requestInfoFlight(urlString: url, completion: {(result) in
            switch result {
                case .success(let flights):
                    for i in 0...(flights.count - 1){
                        if(flights[i].allplace != 0){
                            let url = "http://localhost:3000/api/getVagon/\(flights[i].fl_id)"
                            self.networkService.requestAllVagonFlight(urlString: url, completion: {(result) in
                                switch result{
                                case .success(let vagon):
                                    var nameVagon: [String] = []
                                    var countPlace: [String] = []
                                    var countVagon: [Int] = []
                                    for j in 0...(vagon.count - 1){
                                        if(vagon[j].count_pl != 0){
                                            nameVagon.append(vagon[j].tc_name)
                                            countPlace.append(String(vagon[j].count_pl))
                                            countVagon.append(vagon[j].count_vagon)
                                        }
                                    }
                                    self.tableViewData.append(CellData(opened: false, tr_id: flights[i].tr_id,typeTrain: flights[i].tr_type,   numTrain: String(flights[i].tr_num), km: flights[i].km, fl_id: flights[i].fl_id, direction: self.stationBegin + "-" + self.smh(seconds: flights[i].time_way) + "-" + self.stationEnd, timeBeginWay: flights[i].dateArr, timeEndWay: flights[0].dateSend, availablePlace: String(flights[i].allplace), sectionTypeRailway_carriage: nameVagon, sectionCountPlace: countPlace, countVagon: countVagon))
                                    OperationQueue.main.addOperation {
                                        self.viewTable.reloadData()
                                    }
                                case .failure(_):
                                    print("Error")
                            
                                }
                            })
                        }
                    }
                    OperationQueue.main.addOperation {
                        self.viewTable.reloadData()
                    }
                case .failure(_):
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 21))
                    label.center = CGPoint(x: 210, y: 300)
                    label.textAlignment = .center
                    label.text = "По заданному Вами направлению мест нет."
                    label.textColor = .gray
                    self.view.addSubview(label)
            }
        })
    }
    func smh(seconds : Int) -> String {
  
        return String(seconds / 3600) + ":" + String((seconds % 3600) / 60)
    }

    @IBAction func pushComeBack(_ sender: UIBarButtonItem) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableViewData[section].opened == true){
            return tableViewData[section].sectionTypeRailway_carriage.count + 1
        }else{
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindRouteTableViewCell") as! FindRouteTableViewCell
            cell.typeTrainLabel.text = tableViewData[indexPath.section].typeTrain
            cell.numTrainLabel.text = tableViewData[indexPath.section].numTrain
            cell.directionLabel.text = tableViewData[indexPath.section].direction
            cell.timeBeginWayLabel.text = tableViewData[indexPath.section].timeBeginWay
            cell.timeEndWayLabel.text = tableViewData[indexPath.section].timeEndWay
            cell.availablePlaceLabel.text = tableViewData[indexPath.section].availablePlace
            numRoute = tableView.tag
            cell.delegate = self
            return cell
        }else{
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: "FindRouteTableViewCell1") else {return UITableViewCell()}
            cell.backgroundColor = .systemGray4
            cell.textLabel?.text = tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1]
            cell.detailTextLabel?.text = tableViewData[indexPath.section].sectionCountPlace[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row != 0){
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            if(tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1] == "Плацкарт"){
                let sb = storyboard?.instantiateViewController(identifier: "ReservedSeatViewController") as! ReservedSeatViewController
                sb.modalPresentationStyle = .fullScreen
                sb.km = tableViewData[indexPath.section].km
                sb.tr_id = tableViewData[indexPath.section].tr_id
                sb.numTrain = tableViewData[indexPath.section].numTrain
                sb.typeTrain = tableViewData[indexPath.section].typeTrain
                sb.beginStation = stationBegin
                sb.endStation = stationEnd
                sb.dateArr = tableViewData[indexPath.section].timeBeginWay
                sb.dateSend = tableViewData[indexPath.section].timeEndWay
                sb.fl_id = tableViewData[indexPath.section].fl_id
                self.present(sb, animated: false)
            }
            if(tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1] == "Купе"){
                let sb = storyboard?.instantiateViewController(identifier: "CoupeViewController") as! CoupeViewController
                sb.modalPresentationStyle = .fullScreen
                sb.km = tableViewData[indexPath.section].km
                sb.tr_id = tableViewData[indexPath.section].tr_id
                sb.numTrain = tableViewData[indexPath.section].numTrain
                sb.typeTrain = tableViewData[indexPath.section].typeTrain
                sb.beginStation = stationBegin
                sb.endStation = stationEnd
                sb.dateArr = tableViewData[indexPath.section].timeBeginWay
                sb.dateSend = tableViewData[indexPath.section].timeEndWay
                sb.fl_id = tableViewData[indexPath.section].fl_id
                self.present(sb, animated: false)
            }
            if(tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1] == "Люкс"){
                let sb = storyboard?.instantiateViewController(identifier: "LuxuryViewController") as! LuxuryViewController
                    sb.km = tableViewData[indexPath.section].km
                    sb.tr_id = tableViewData[indexPath.section].tr_id
                    sb.numTrain = tableViewData[indexPath.section].numTrain
                    sb.typeTrain = tableViewData[indexPath.section].typeTrain
                sb.beginStation = stationBegin
                sb.endStation = stationEnd
                sb.dateArr = tableViewData[indexPath.section].timeBeginWay
                sb.dateSend = tableViewData[indexPath.section].timeEndWay
                sb.fl_id = tableViewData[indexPath.section].fl_id
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: false)
            }
            if(tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1] == "Сидячий1класса"){
                let sb = storyboard?.instantiateViewController(identifier: "SeatPlaceViewController") as! SeatPlaceViewController
                sb.typeVagon = "Cидячий1класса"
                sb.km = tableViewData[indexPath.section].km
                sb.tr_id = tableViewData[indexPath.section].tr_id
                sb.numTrain = tableViewData[indexPath.section].numTrain
                sb.typeTrain = tableViewData[indexPath.section].typeTrain
                sb.beginStation = stationBegin
                sb.endStation = stationEnd
                sb.dateArr = tableViewData[indexPath.section].timeBeginWay
                sb.dateSend = tableViewData[indexPath.section].timeEndWay
                sb.fl_id = tableViewData[indexPath.section].fl_id
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: false)
            }
            if(tableViewData[indexPath.section].sectionTypeRailway_carriage[indexPath.row - 1] == "Сидячий2класса"){
                let sb = storyboard?.instantiateViewController(identifier: "SeatPlaceViewController") as! SeatPlaceViewController
                sb.typeVagon = "Cидячий2класса"
                sb.km = tableViewData[indexPath.section].km
                sb.tr_id = tableViewData[indexPath.section].tr_id
                sb.numTrain = tableViewData[indexPath.section].numTrain
                sb.typeTrain = tableViewData[indexPath.section].typeTrain
                sb.beginStation = stationBegin
                sb.endStation = stationEnd
                sb.dateArr = tableViewData[indexPath.section].timeBeginWay
                sb.dateSend = tableViewData[indexPath.section].timeEndWay
                sb.fl_id = tableViewData[indexPath.section].fl_id
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: false)
            }
        }
        if tableViewData[indexPath.section].opened == true && indexPath.row == 0{
                tableViewData[indexPath.section].opened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }else{
                tableViewData[indexPath.section].opened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 165
        }else{
            return 50
        }
    }
    func didTapRain() {
         let transition = CATransition()
         transition.duration = 0.5
         transition.type = CATransitionType.push
         transition.subtype = CATransitionSubtype.fromRight
         transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
         view.window!.layer.add(transition, forKey: kCATransition)
         let sb = storyboard?.instantiateViewController(identifier: "RouteViewController") as! RouteViewController
         sb.fl_id = tableViewData[numRoute].fl_id
         sb.modalPresentationStyle = .fullScreen
         self.present(sb, animated: false)
     }
}
