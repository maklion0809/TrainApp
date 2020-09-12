//
//  AuthViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 12.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    let AuthRow: Int = 0
    let transiton = SlideInTransition()
    
    var signup: Bool = true{
        willSet{
            if newValue{
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                accauntButton.isHidden = true
                LogInButton.isHidden = true
                accauntButton.isHidden = true
                LogInButton.isHidden = true
                confirmPasswordField.isHidden = false
                regustrationButton.isHidden = false
                comeIt.isHidden = false
                fogotPasswordButton.isHidden = true
            }else{
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                accauntButton.isHidden = false
                LogInButton.isHidden = false
                confirmPasswordField.isHidden = true
                regustrationButton.isHidden = true
                accauntButton.isHidden = false
                LogInButton.isHidden = false
                comeIt.isHidden = true
                fogotPasswordButton.isHidden = false
            }
        }
    }
    @IBOutlet weak var fogotPasswordButton: UIButton!
    @IBOutlet weak var comeIt: UIButton!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var regustrationButton: UIButton!
    @IBOutlet weak var accauntButton: UIButton!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBAction func pushAccauntButton(_ sender: UIButton) {
        signup = !signup
    }
    @IBAction func pushLogInButton(_ sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        if(!signup){
            if(!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
                    if error == nil{
                        let transition = CATransition()
                        transition.duration = 0.5
                        transition.type = CATransitionType.push
                        transition.subtype = CATransitionSubtype.fromRight
                        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                        self.view.window!.layer.add(transition, forKey: kCATransition)
                        let sb = self.storyboard?.instantiateViewController(identifier: "UserAccountVC") as! UserAccountViewController
                        sb.modalPresentationStyle = .fullScreen
                        self.present(sb, animated: false)
                    }else{
                        self.showAlert(message: "Неверный логин или пароль.")
                    }
                }
            }else{
                showAlert(message: "Заполните все поля.")
            }
        }
    }
    @IBAction func pushRegistrationButton(_ sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        let confirmPassword = confirmPasswordField.text!
        if(signup){
           if(!email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty){
            let t: Bool = isValidEmail(testStr: email)
            if(t){
                if(password == confirmPassword){
                    Auth.auth().createUser(withEmail: email, password: password){(result, error) in
                        if(error == nil){
                            if result != nil{
                               let ref = Database.database().reference().child("users")
                                ref.child(result!.user.uid).updateChildValues(["name": ""])
                                ref.child(result!.user.uid).updateChildValues(["surname": ""])
                                ref.child(result!.user.uid).updateChildValues(["phone": ""])
                                ref.child(result!.user.uid).updateChildValues(["email": email])
                                ref.child(result!.user.uid).updateChildValues(["whoAmI": ""])
                                let transition = CATransition()
                                transition.duration = 0.5
                                transition.type = CATransitionType.push
                                transition.subtype = CATransitionSubtype.fromRight
                                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                                self.view.window!.layer.add(transition, forKey: kCATransition)
                                let sb = self.storyboard?.instantiateViewController(identifier: "UserAccountVC") as! UserAccountViewController
                                sb.modalPresentationStyle = .fullScreen
                                self.present(sb, animated: false)
                            }
                        }else{
                            self.showAlert(message: "Что-то пошло не так.)")
                        }
                    
                    }
                }else{
                   self.showAlert(message: "Пароли не совпадают")
                }
            }else{
                showAlert(message: "Неправильный email.")
            }
           }else{
               showAlert(message: "Заполните все поля")
           }
        }
    }
    @IBAction func pushСomeIt(_ sender: Any) {
        signup = !signup
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInButton.layer.cornerRadius = 24
        regustrationButton.layer.cornerRadius = 24
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func pushMune(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = AuthRow
        present(menuViewController, animated: true)
    }
    @IBAction func pushFogotPassword(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let sb = storyboard?.instantiateViewController(identifier: "FogotPasswordVC") as! FogotPasswordViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false)
    }
    
    
}

extension AuthViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

