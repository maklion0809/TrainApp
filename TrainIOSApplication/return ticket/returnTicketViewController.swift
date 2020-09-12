//
//  returnTicketViewController.swift
//  TrainApplication
//
//  Created by Тимофей on 11.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit

class returnTicketViewController: UIViewController {
    
    @IBOutlet weak var returnTicketButton: UIButton!
    let returnTicketRow: Int = 3
    let transiton = SlideInTransition()
    @IBOutlet weak var numTicketText: UITextField!
    
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnTicketButton.layer.cornerRadius = 24
    }
    
    @IBAction func pushMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.numRow = returnTicketRow
        present(menuViewController, animated: true)
    }
    
    @IBAction func pushReturnTicket(_ sender: UIButton) {
        let numTic = numTicketText.text
        if(!numTic!.isEmpty){
            let url = "http://localhost:3000/api/getTicket?num=\(numTic!)"
            networkService.requestReturnTicket(urlString: url, completion: {(result) in
                switch result{
                case .success(let ticket):
                    print(ticket)
                    let alert = UIAlertController(title: "Подтвердите действие.", message: "Вам вернется сумма в размере половины от уплаченной, вы действиетльно хотите вернуть билет?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action: UIAlertAction) in
                        let urlDeleteServer = "http://localhost:3000/api/deleteServer?tic_id=\(ticket[0].tic_id)"
                        let requestDeleteServer = NSMutableURLRequest(url: URL(string: urlDeleteServer)!)
                        requestDeleteServer.httpMethod = "DELETE"
                        let taskDeleteServer = URLSession.shared.dataTask(with: requestDeleteServer as URLRequest)
                        taskDeleteServer.resume()
                        
  
                        let urlDeleteTicket = "http://localhost:3000/api/deleteTicket?tic_id=\(ticket[0].tic_id)"
                        let requestDeleteTicket = NSMutableURLRequest(url: URL(string: urlDeleteTicket)!)
                        requestDeleteTicket.httpMethod = "DELETE"
                        let taskDeleteTicket = URLSession.shared.dataTask(with: requestDeleteTicket as URLRequest)
                        taskDeleteTicket.resume()
                        
                        
                        let urlDeletePassenger = "http://localhost:3000/api/deletePassenger?pas_id=\(ticket[0].pas_id)"
                        let requestDeletePassenger = NSMutableURLRequest(url: URL(string: urlDeletePassenger)!)
                        requestDeletePassenger.httpMethod = "DELETE"
                        let taskDeletePassenger = URLSession.shared.dataTask(with: requestDeletePassenger as URLRequest)
                        taskDeletePassenger.resume()
                   
                        let urlDeleteDocument = "http://localhost:3000/api/deleteDocument?doc_id=\(ticket[0].doc_id)"
                        let requestDeleteDocumet = NSMutableURLRequest(url: URL(string: urlDeleteDocument)!)
                        requestDeleteDocumet.httpMethod = "DELETE"
                        let taskDeleteDocument = URLSession.shared.dataTask(with: requestDeleteDocumet as URLRequest)
                        taskDeleteDocument.resume()
                        
                        let alert1 = UIAlertController(title: "Успешно!", message: "Билет был возвращен.", preferredStyle: .alert)
                        alert1.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                        self.present(alert1, animated: true, completion: nil)
                        if(UserSettings.myTicketActual.count != 0){
                            for i in 0...(UserSettings.myTicketActual.count - 1){
                                if(UserSettings.myTicketActual[i].numTicket == self.numTicketText.text){
                                    UserSettings.myTicketActual.remove(at: i)
                                }
                            }
                        }
                        self.numTicketText.text = ""
                    }))
                    alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case .failure(_):
                    let alert = UIAlertController(title: "Ошибка!", message: "Неверно введен номер билета.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Ошибка!", message: "Заполните поле.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
        }
    }
    
    
}
extension returnTicketViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
