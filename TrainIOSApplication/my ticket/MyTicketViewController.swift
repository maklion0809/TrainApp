//
//  MyTicketViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 15.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class MyTicketCellData: NSObject, NSCoding{
    
    var opened: Bool
    let numTicket: String
    let numTrain: String
    let direction: String
    let dateSend: String
    let infoPlace: String
    let nameSurname: String
    let name: [String]
    let data: [String]
    
    init(opened: Bool, numTicket: String, numTrain: String, direction:String, dateSend: String, infoPlace: String, nameSurname: String, name: [String], data: [String]){
        self.opened = opened
        self.numTicket = numTicket
        self.numTrain = numTrain
        self.direction = direction
        self.dateSend = dateSend
        self.infoPlace = infoPlace
        self.nameSurname = nameSurname
        self.name = name
        self.data = data
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(opened, forKey: "opened")
        coder.encode(numTicket, forKey: "numTicket")
        coder.encode(numTrain, forKey: "numTrain")
        coder.encode(direction, forKey: "direction")
        coder.encode(dateSend, forKey: "dateSend")
        coder.encode(infoPlace, forKey: "infoPlace")
        coder.encode(nameSurname, forKey: "nameSurname")
        coder.encode(name, forKey: "name")
        coder.encode(data, forKey: "data")
    }
    
    required init?(coder: NSCoder) {
        opened = coder.decodeObject(forKey: "opened") as? Bool ?? false
        numTicket = (coder.decodeObject(forKey: "numTicket") as? String)!
        numTrain = (coder.decodeObject(forKey: "numTrain") as? String)!
        direction = (coder.decodeObject(forKey: "direction") as? String)!
        dateSend = (coder.decodeObject(forKey: "dateSend") as? String)!
        infoPlace = (coder.decodeObject(forKey: "infoPlace") as? String)!
        nameSurname = (coder.decodeObject(forKey: "nameSurname") as? String)!
        name = (coder.decodeObject(forKey: "name") as? [String])!
        data = (coder.decodeObject(forKey: "data") as? [String])!
    }
    
}


class MyTicketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DeleteTicketHistory{
    
    var myTicketCellDataActual: [MyTicketCellData] = []
    var myTicketCellDataHistory: [MyTicketCellData] = []
    
    var numTicket: Int = 0
    let MyTicketRow: Int = 1
    let transiton = SlideInTransition()
    var changed: Int = 0
    @IBOutlet weak var tableView: UITableView!
    @IBAction func pushSegmentMyTicket(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            changed = 0
            myTicketCellDataActual = UserSettings.myTicketActual
            compare()
            tableView.reloadData()
        }else{
            changed = 1
            myTicketCellDataHistory = UserSettings.myTicketHistory
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(changed == 0){
            myTicketCellDataActual = UserSettings.myTicketActual
            compare()
            tableView.reloadData()
        }
    }
    
    func compare(){
        if(myTicketCellDataActual.count != 0){
            var i: Int = 0
            var t: Bool = false
            var count = myTicketCellDataActual.count
            while(i <= count - 1){
                let word = myTicketCellDataActual[i].dateSend
                if let index = word.range(of: " ")?.lowerBound {
                    let substring = word[..<index]
                    let myDateInString = String(substring)
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyy-MM-dd"
                    let date = formatter.date(from: myDateInString)
                    let stringDate1 = formatter.string(from: date!)
                
                    let formatterDate = DateFormatter()
                    formatterDate.dateFormat = "yyyy-MM-dd"
                    formatterDate.locale = Locale.current
                    let stringDate2 = formatterDate.string(from: Date())
                
                    switch stringDate1.compare(stringDate2) {
                        case .orderedSame:
                            let word1 = myTicketCellDataActual[i].dateSend
                            var hour: Int = 0
                            var minut: Int = 0
                            var stringTime = ""
                            var k = 0
                            for j in 11...16{
                                let index = word1.index(word1.startIndex, offsetBy: j)
                                if(String(word1[index]) != ":"){
                                    stringTime = stringTime + String(word1[index])
                                }else{
                                    switch k {
                                    case 0:
                                        hour = (Int(stringTime)!)*3600
                                        k = k + 1
                                    case 1:
                                        minut = (Int(stringTime)!)*60
                                        k = k + 1
                                    default: break
                                    }
                                    stringTime = ""
                                }
                            }
                            let formatterTime = DateFormatter()
                            formatterTime.dateFormat = "HH:mm:ss"
                            formatterTime.locale =  Locale(identifier: "ru_RU")
                            let word2 = formatterTime.string(from: Date())
                            var hour1: Int = 0
                            var minut1: Int = 0
                            var second1: Int = 0
                            var stringTime1 = ""
                            var k1 = 0
                            for j in 0...7{
                                let index = word2.index(word2.startIndex, offsetBy: j)
                                if(String(word2[index]) != ":"){
                                    stringTime1 = stringTime1 + String(word2[index])
                                }else{
                                    switch k1 {
                                    case 0:
                                        hour1 = (Int(stringTime1)!)*3600
                                        k1 = k1 + 1
                                    case 1:
                                        minut1 = (Int(stringTime1)!)*60
                                        k1 = k1 + 1
                                    case 2:
                                        second1 = (Int(stringTime1)!)*1
                                    default: break
                                    }
                                    stringTime1 = ""
                                }
                            }
                            if((hour + minut) < (hour1 + minut1 + second1)){
                                myTicketCellDataHistory.append(myTicketCellDataActual[i])
                                myTicketCellDataActual.remove(at: i)
                                count = count - 1
                                t = true
                            }else{
                            }
                        case .orderedAscending:
                            myTicketCellDataHistory.append(myTicketCellDataActual[i])
                            myTicketCellDataActual.remove(at: i)
                            count = count - 1
                            t = true
                    case .orderedDescending: break
                    }
                }
                if(t != true){
                    i = i + 1
                }else{
                   t = false
                }
            }
            UserSettings.myTicketHistory = myTicketCellDataHistory
            UserSettings.myTicketActual = myTicketCellDataActual
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(changed == 0){
            return myTicketCellDataActual.count
        }else{
            return myTicketCellDataHistory.count
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(changed == 0){
            if (myTicketCellDataActual[section].opened == true){
                return myTicketCellDataActual[section].name.count + 2
            }else{
                return 1
            }
        }else{
            if (myTicketCellDataHistory[section].opened == true){
                return myTicketCellDataHistory[section].name.count + 2
            }else{
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(changed == 0){
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell") as! MyTicketTableViewCell
                cell.numTicketLabel.text = myTicketCellDataActual[indexPath.section].numTicket
                cell.numTrainLabel.text = myTicketCellDataActual[indexPath.section].numTrain
                cell.directionLabel.text = myTicketCellDataActual[indexPath.section].direction
                cell.dataSendLabel.text = myTicketCellDataActual[indexPath.section].dateSend
                cell.infoPlaceLabel.text = myTicketCellDataActual[indexPath.section].infoPlace
                cell.nameSurnameLabel.text = myTicketCellDataActual[indexPath.section].nameSurname
                cell.deleteButton.isHidden = true
                return cell
            }else if(indexPath.row == 5){
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell2") as! MyTicketQRTableViewCell
                let myString = ("\(myTicketCellDataActual[indexPath.section].numTicket)\n\(myTicketCellDataActual[indexPath.section].numTicket)\n\(myTicketCellDataActual[indexPath.section].dateSend)-\(myTicketCellDataActual[indexPath.section].name[1])\n\(myTicketCellDataActual[indexPath.section].numTrain)\n\(myTicketCellDataActual[indexPath.section].infoPlace)" as NSString).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                       
                cell.imageQR.image = generateQRCode(from: transliterate(nonLatin: myString!))
                    return cell
            }else{
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell1") else {return UITableViewCell()}
                cell.backgroundColor = .systemGray5
                cell.textLabel?.text = myTicketCellDataActual[indexPath.section].name[indexPath.row - 1]
                cell.detailTextLabel?.text = myTicketCellDataActual[indexPath.section].data[indexPath.row - 1]
                return cell
            }
        }else{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell") as! MyTicketTableViewCell
                cell.numTicketLabel.text = myTicketCellDataHistory[indexPath.section].numTicket
                cell.numTrainLabel.text = myTicketCellDataHistory[indexPath.section].numTrain
                cell.directionLabel.text = myTicketCellDataHistory[indexPath.section].numTicket
                cell.dataSendLabel.text = myTicketCellDataHistory[indexPath.section].dateSend
                cell.infoPlaceLabel.text = myTicketCellDataHistory[indexPath.section].infoPlace
                cell.nameSurnameLabel.text = myTicketCellDataHistory[indexPath.section].nameSurname
                numTicket = tableView.tag
                cell.delegate = self
                return cell
                
            }else if(indexPath.row == 5){
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell2") as! MyTicketQRTableViewCell
                let myString = ("\(myTicketCellDataHistory[indexPath.section].numTicket)\n\(myTicketCellDataHistory[indexPath.section].numTicket)\n\(myTicketCellDataHistory[indexPath.section].dateSend)-\(myTicketCellDataHistory[indexPath.section].name[1])\n\(myTicketCellDataHistory[indexPath.section].numTrain)\n\(myTicketCellDataHistory[indexPath.section].infoPlace)" as NSString).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    cell.imageQR.image = generateQRCode(from: transliterate(nonLatin: myString!))
                return cell
            }else{
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketTableViewCell1") else {return UITableViewCell()}
                cell.backgroundColor = .systemGray5
                cell.textLabel?.text = myTicketCellDataHistory[indexPath.section].name[indexPath.row - 1]
                cell.detailTextLabel?.text = myTicketCellDataHistory[indexPath.section].data[indexPath.row - 1]
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 250
        }else if(indexPath.row == 5){
            return 232
        }else{
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(changed == 0){
            if myTicketCellDataActual[indexPath.section].opened == true && indexPath.row == 0{
                tableView.deselectRow(at: indexPath, animated: true)
                myTicketCellDataActual[indexPath.section].opened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }else{
                myTicketCellDataActual[indexPath.section].opened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }
        }else{
            if myTicketCellDataHistory[indexPath.section].opened == true && indexPath.row == 0{
                tableView.deselectRow(at: indexPath, animated: true)
                myTicketCellDataHistory[indexPath.section].opened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }else{
                myTicketCellDataHistory[indexPath.section].opened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            }
        }
    }
    func didTapDelete() {
        myTicketCellDataHistory.remove(at: numTicket)
        UserSettings.myTicketHistory = myTicketCellDataHistory
        tableView.reloadData()
    }
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = MyTicketRow
        present(menuViewController, animated: true)
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    func transliterate(nonLatin: String) -> String {
        let mut = NSMutableString(string: nonLatin) as CFMutableString
        CFStringTransform(mut, nil, "Any-Latin; Latin-ASCII; Any-Lower;" as CFString, false)
        return (mut as String).replacingOccurrences(of: " ", with: "-")
    }
}

extension MyTicketViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
