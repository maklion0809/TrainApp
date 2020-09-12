//
//  RouteViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 19.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let networkService = NetworkService()
    var fl_id: Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    var route: [Route] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "http://localhost:3000/api/getR/\(fl_id)"
        networkService.requestRoute(urlString: urlString, completion: {(result) in
            switch result {
                case .success(let flights):
                    self.route = flights
                    print(self.route)
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                case .failure(_):
                print("Error")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell
        cell.cityLabel.text = route[indexPath.row].r_st
        if(route[indexPath.row].r_d_t_sed == "0"){
            cell.arrLabel.text = "-"
        }else{
            cell.arrLabel.text = route[indexPath.row].r_d_t_sed
        }
        if(route[indexPath.row].r_d_t_arr == "0"){
            cell.sendLabel.text = "-"
        }else{
            cell.sendLabel.text = route[indexPath.row].r_d_t_arr
        }
        if(route[indexPath.row].r_park == 0){
            cell.parkLabel.text = "-"
        }else{
            cell.parkLabel.text = String(route[indexPath.row].r_park) + " мин."
        }
        if(String(route[indexPath.row].r_time_way) == "0"){
            cell.kmLabel.text = "-"
        }else{
            cell.kmLabel.text = String(route[indexPath.row].r_time_way)
        }
            cell.inWayLabel.text = String(route[indexPath.row].r_km)
           return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
