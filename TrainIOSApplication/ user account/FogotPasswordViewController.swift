//
//  FogotPasswordViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 15.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
import FirebaseAuth

class FogotPasswordViewController: UIViewController {

    @IBOutlet weak var fogotPasswordButton: UIButton!
    @IBOutlet weak var emeilText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fogotPasswordButton.layer.cornerRadius = 24
    }
    @IBAction func pushFogotPassword(_ sender: UIButton) {
        let email = emeilText.text!
        if(!email.isEmpty){
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil{
                    let alert = UIAlertController(title: "Успешно!", message: "Вам на почту поступило сообщение для подтверждения дейтсвия.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Ошибка!", message: "Неправильный email.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            let alert = UIAlertController(title: "Ошибка!", message: "Заполните поле.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
