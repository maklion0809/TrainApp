//
//  UserAccountViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
import Firebase

class UserAccountViewController: UIViewController {
    
   
    let UserAccountRow: Int = 0
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var iamStudent: UIImageView!
    @IBOutlet weak var iamPilg: UIImageView!
    @IBOutlet weak var buttonIAmStudent: UIButton!
    @IBOutlet weak var buttonIAmPilg: UIButton!
    
    @IBAction func pushIAmStudent(_ sender: UIButton) {
        iamStudent.isHidden = !iamStudent.isHidden
        iamPilg.isHidden = true
    }
    @IBAction func pushIAmPilg(_ sender: UIButton) {
        iamStudent.isHidden = true
        iamPilg.isHidden = !iamPilg.isHidden
    }
    
    
    
    let transiton = SlideInTransition()

    
    @IBOutlet weak var LogOut: UIButton!
    @IBAction func pushLogOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
    }
    @IBOutlet weak var SaveData: UIButton!
    @IBAction func pushSaveData(_ sender: UIButton) {
        let ref = Database.database().reference()
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/name").setValue(nameText.text)
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/surname").setValue(surnameText.text)
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/phone").setValue(phoneText.text)
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/whoAmI").observeSingleEvent(of: .value){(snapshot) in
            if(snapshot.value as? String != "Я студент" && !self.iamStudent.isHidden){
                ref.child("users/\(String(Auth.auth().currentUser!.uid))/whoAmI").setValue("Я студент")
            }else if(snapshot.value as? String != "Я льготник" && !self.iamPilg.isHidden){
                ref.child("users/\(String(Auth.auth().currentUser!.uid))/whoAmI").setValue("Я льготник")
            }else{
                ref.child("users/\(String(Auth.auth().currentUser!.uid))/whoAmI").setValue(" ")
            }
        }
        let alert = UIAlertController(title: "Успешно!", message: "Сохранено.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func pushExit(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            let transition = CATransition()
              transition.duration = 0.5
              transition.type = CATransitionType.push
              transition.subtype = CATransitionSubtype.fromLeft
              transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
              view.window!.layer.add(transition, forKey: kCATransition)
            let sb = self.storyboard?.instantiateViewController(identifier: "AuthVC") as! AuthViewController
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }catch{
            print("Error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveData.layer.cornerRadius = 24
        let ref = Database.database().reference()
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/name").observeSingleEvent(of: .value){(snapshot) in
            self.nameText.text = snapshot.value as? String
        }
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/surname").observeSingleEvent(of: .value){(snapshot) in
            self.surnameText.text = snapshot.value as? String
        }
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/phone").observeSingleEvent(of: .value){(snapshot) in
            self.phoneText.text = snapshot.value as? String
        }
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/email").observeSingleEvent(of: .value){(snapshot) in
            self.emailText.text = snapshot.value as? String
        }
        ref.child("users/\(String(Auth.auth().currentUser!.uid))/whoAmI").observeSingleEvent(of: .value){(snapshot) in
            if(snapshot.value as? String == "Я льготник"){
                self.iamPilg.isHidden = false
            }else if(snapshot.value as? String == "Я студент"){
                self.iamStudent.isHidden = false
            }
        }
    }
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = UserAccountRow
        present(menuViewController, animated: true)
    }
    
}

extension UserAccountViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
