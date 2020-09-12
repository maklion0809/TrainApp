//
//  UserSettings.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 29.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import Foundation

final class UserSettings{
    private enum SettingKeys: String{
        case Actual
        case History
    }
    
    static var myTicketActual: [MyTicketCellData]{
        get{
            guard let savedData = UserDefaults.standard.object(forKey: SettingKeys.Actual.rawValue) as? Data, let decodedModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [MyTicketCellData] else{return []}
            return decodedModal
            
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingKeys.Actual.rawValue
            if let myTicketActual: [MyTicketCellData] = newValue{
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: myTicketActual, requiringSecureCoding: false){
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
    static var myTicketHistory: [MyTicketCellData]{
        get{
            guard let savedData = UserDefaults.standard.object(forKey: SettingKeys.History.rawValue) as? Data, let decodedModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [MyTicketCellData] else{return []}
            return decodedModal
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingKeys.History.rawValue
            if let myTicketHistory: [MyTicketCellData] = newValue{
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: myTicketHistory, requiringSecureCoding: false){
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}
