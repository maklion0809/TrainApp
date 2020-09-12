//
//  CoupeViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 16.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class CoupeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource{

    //передача данных сюда
    var fl_id: Int = 0
    var beginStation: String?
    var endStation: String?
    var dateSend: String?
    var dateArr: String?
    var typeTrain: String?
    var numTrain: String?
    var tr_id: Int = 0
    var km: Int = 0
    
    var name: [NamePlaceString] = []
    var place: [ReservedPlaceString] = []
    let networkService = NetworkService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://localhost:3000/api/getSpecV?train=\(tr_id)&vagon=Купе"
         networkService.requestReservedPlace(urlString: url, completion: {(result) in
             switch result{
                 case .success(let placeS):
                     if(placeS.count > 1){
                         var placeNumber: [String] = []
                         placeNumber.append(String(placeS[0].pl_num))
                         for i in 1...(placeS.count - 1){
                             if(placeS[i].rc_id == placeS[i-1].rc_id && i != placeS.count - 1){
                                 placeNumber.append(String(placeS[i].pl_num))
                             }else{
                                 if(placeS.count != i){
                                     placeNumber.append(String(placeS[i].pl_num))
                                 }
                                 self.place.append(ReservedPlaceString(rc_id: String(placeS[i-1].rc_id), pl_num: placeNumber))
                                 placeNumber.removeAll()
                             }
                         }
                     }else{
                         self.place.append(ReservedPlaceString(rc_id: String(placeS[0].rc_id), pl_num: [String(placeS[0].pl_num)]))
                     }
                     let urlString = "http://localhost:3000/api/getNumVagon?train=\(self.tr_id)&vagon=Купе"
                     self.networkService.requestNumVagon(urlString: urlString, completion: {(result) in
                         switch result{
                             case .success(let numVagon):
                                var count = 0
                                 for i in 0...(numVagon.count - 1){
                                     self.name.append(NamePlaceString(nameString: String(numVagon[i].rc_num), numString: ["2","1","4","3","6","5","8","7","10","9","12","11","14","13","16","15","18","17","20","19","22","21","24","23","26","25","28","27","30","29","32","31","34","33","36","35"]))
                                    for j in 0...(self.place.count - 1){
                                        if(self.place[j].rc_id == self.name[i].nameString){
                                            for k in 0...(self.place[j].pl_num.count-1){
                                                for g in 0...(self.name[i].numString.count - 1){
                                                    if(self.place[j].pl_num[k] == self.name[i].numString[g]){
                                                        self.name[i].numString[g] = "-" + self.name[i].numString[g]
                                                        count = count + 1
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if(count == self.name[i].numString.count){
                                        self.name.remove(at: i)
                                    }
                                    count = 0
                                 }
                                 OperationQueue.main.addOperation {
                                     self.tableView.reloadData()
                                 }
                             case .failure(_):
                                 print("Error")
                         }
                     })
                     OperationQueue.main.addOperation {
                         self.tableView.reloadData()
                     }
             case .failure(_):
                     print("Error")
                    let urlString = "http://localhost:3000/api/getNumVagon?train=\(self.tr_id)&vagon=Купе"
                    self.networkService.requestNumVagon(urlString: urlString, completion: {(result) in
                        switch result{
                            case .success(let numVagon):
                                for i in 0...(numVagon.count - 1){
                                    self.name.append(NamePlaceString(nameString: String(numVagon[i].rc_num), numString: ["2","1","4","3","6","5","8","7","10","9","12","11","14","13","16","15","18","17","20","19","22","21","24","23","26","25","28","27","30","29","32","31","34","33","36","35"]))
                                }
                                OperationQueue.main.addOperation {
                                    self.tableView.reloadData()
                                }
                            case .failure(_):
                                print("Error")
                        }
                    })
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
             }
         })
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return name[collectionView.tag].numString.count
       }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoupeCollectionViewCell", for: indexPath) as! CoupeCollectionViewCell
          if(Int(name[collectionView.tag].numString[indexPath.row])! < 0){
              cell.numPlaceLabel.text = String(Int(name[collectionView.tag].numString[indexPath.row])!*(-1))
              cell.backgroundColor = .systemGray4
          }else{
              cell.numPlaceLabel.text = name[collectionView.tag].numString[indexPath.row]
            cell.backgroundColor = .black
          }
          return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 50, height: 50)
    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var price: Double
        if(typeTrain == "Cкоростной"){
            price = Double(km) * 1.5
        }else if(typeTrain == "Пасажирский"){
            price = Double(km)
        }else{
            price = Double(km)
        }
        if(Int(name[collectionView.tag].numString[indexPath.row])! > 0){
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            let sb = self.storyboard?.instantiateViewController(identifier: "RegistrationViewController") as! RegistrationViewController
            sb.numVagon = name[collectionView.tag].nameString
            sb.numTrain = numTrain
            sb.numPlace = name[collectionView.tag].numString[indexPath.row]
            sb.price = price
            sb.beginStation = beginStation
            sb.endStation = endStation
            sb.dateSend = dateSend
            sb.dateArr = dateArr
            sb.fl_id = fl_id
            sb.tr_id = tr_id
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoupeTableViewCell", for: indexPath) as! CoupeTableViewCell
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.railway_carriageLabel.text = name[indexPath.row].nameString
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
