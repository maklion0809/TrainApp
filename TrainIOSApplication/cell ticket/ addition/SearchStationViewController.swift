//
//  SearchStationViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit


class SearchStationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var num: Int = 0
    
    var delegate: CellTicketViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    let networkService = NetworkService()
    var stationName: [String] = []
    var searchedCountry: [String] = []
    
    var searching = false
    
    @IBOutlet weak var countrySearch: UISearchBar!
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countrySearch.delegate = self
        
        let urlString = "http://localhost:3000/api/getStation"
        networkService.requestAllStation(urlString: urlString, completion: {(result) in
            switch result {
            case .success(let flights):
                for i in 0...(flights.count - 1){
                    self.stationName.append(flights[i].r_st)
                }
                OperationQueue.main.addOperation {
                   self.tableView.reloadData()
                }
            case .failure(_):
                print("Error")
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCountry.count
        } else {
            return stationName.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchedCountry[indexPath.row]
        } else {
            cell?.textLabel?.text = stationName[indexPath.row]
        }
        return cell!
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(num == 1){
            if(searchedCountry.isEmpty){
                delegate?.update(text: stationName[indexPath.row], num: num)
            }else{
                delegate?.update(text: searchedCountry[indexPath.row], num: num)
            }
        }else{
            if(searchedCountry.isEmpty){
                delegate?.update(text: stationName[indexPath.row], num: num)
            }else{
                delegate?.update(text: searchedCountry[indexPath.row], num: num)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SearchStationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCountry = stationName.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tblView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tblView.reloadData()
        dismiss(animated: true)
    }
    
}

