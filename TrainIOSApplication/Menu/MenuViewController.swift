//
//  MenuViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 23.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC", for: indexPath)
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC1", for: indexPath)
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC2", for: indexPath)
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC4", for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC3", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    var numRow: Int?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pushMenuHide(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
         if(numRow != 0){
             let transition = CATransition()
             transition.duration = 0.5
             transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromRight
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             Auth.auth().addStateDidChangeListener{(auth, user) in
                 if user == nil{
                     let sb = self.storyboard?.instantiateViewController(identifier: "AuthVC") as! AuthViewController
                     sb.modalPresentationStyle = .fullScreen
                     self.present(sb, animated: false)
                 }else{
                     let sb = self.storyboard?.instantiateViewController(identifier: "UserAccountVC") as! UserAccountViewController
                     sb.modalPresentationStyle = .fullScreen
                     self.present(sb, animated: false)
                 }
             }
         }else{
             dismiss(animated: true)
         }
     case 1:
         if(numRow != 1){
             let transition = CATransition()
             transition.duration = 0.5
             transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromRight
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             let sb = self.storyboard?.instantiateViewController(identifier: "MyTicketVC") as! MyTicketViewController
             sb.modalPresentationStyle = .fullScreen
             self.present(sb, animated: false)
         }else{
             dismiss(animated: true)
         }
     case 2:
         if (numRow != 2){
             let transition = CATransition()
             transition.duration = 0.5
             transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromRight
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             let sb = self.storyboard?.instantiateViewController(identifier: "CellTicketVC") as! CellTicketViewController
             sb.modalPresentationStyle = .fullScreen
             self.present(sb, animated: false)
         }else{
             dismiss(animated: true)
         }
     case 3:
         if(numRow != 3){
             let transition = CATransition()
             transition.duration = 0.5
             transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromRight
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             Auth.auth().addStateDidChangeListener{(auth, user) in
                 if user == nil{
                     let sb = self.storyboard?.instantiateViewController(identifier: "AutorisationVC") as! AutorisationViewController
                     sb.modalPresentationStyle = .fullScreen
                     self.present(sb, animated: false)
                 }else{
                     let sb = self.storyboard?.instantiateViewController(identifier: "ReturnTicketVC") as! returnTicketViewController
                     sb.modalPresentationStyle = .fullScreen
                     self.present(sb, animated: false)
                 }
             }
         }else{
             dismiss(animated: true)
         }
     default:
         if(numRow != 4){
             let transition = CATransition()
             transition.duration = 0.5
             transition.type = CATransitionType.push
             transition.subtype = CATransitionSubtype.fromRight
             transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
             view.window!.layer.add(transition, forKey: kCATransition)
             let sb = self.storyboard?.instantiateViewController(identifier: "LanguageViewController1") as! LanguageViewController
             sb.modalPresentationStyle = .fullScreen
             self.present(sb, animated: false)
         }else{
             dismiss(animated: true)
         }
     }
    }
}
