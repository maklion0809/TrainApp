//
//  RegistrationViewController.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 16.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class RegistrationViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var priceTicketLabel: UILabel!
    @IBOutlet weak var infoPlaceLabel: UILabel!
    // hide window
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var viewSell: UIView!
    
    var tr_id: Int = 0
    var fl_id: Int = 0
    var beginStation: String?
    var endStation: String?
    var dateSend: String?
    var dateArr: String?
    var numVagon: String?
    var numTrain: String?
    var numPlace: String?
    var price: Double = 0
    var priceP: Double = 0
    var priceCh: Double = 0
    var priceSd: Double = 0
    var pricePil: Double = 0
    
    var numTrainCode: String?
    
    @IBOutlet weak var notnumDocumentImage: UIImageView!
    @IBOutlet weak var numDocumentText: UITextField!
    
    // checkMarks image
    @IBOutlet weak var linesImage: UIImageView!
    @IBOutlet weak var drinks1Image: UIImageView!
    @IBOutlet weak var drinks2Image: UIImageView!
    
    @IBOutlet weak var BuyTicket: UIButton!
    
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var documentText: UITextField!
    
    var changed: Int = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        priceP = price
        priceTicketLabel.text = NSString(format: "%.2f", priceP) as String
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil{
                self.emailText.isHidden = true
                self.emailView.isHidden = true
                self.emailLabel.isHidden = true
                self.viewSell.frame.size.height = 422
            }
                
        }
        
        BuyTicket.layer.cornerRadius = 24
        infoPlaceLabel.text = numTrain! + ", " + numVagon! + " Вагон, " + numPlace! + " место"
        numTrainCode = generationNumTicket(len: 6, numT: numTrain!, numV: numVagon!, numPl: numPlace!)

    }
    func generationNumTicket(len: Int, numT: String, numV: String, numPl: String) -> String{
        let pswdChars = Array("1234567890")
        let numTrain = "TR" + numT + numV + numPl + String((0..<len).map{ _ in pswdChars[Int(arc4random_uniform(UInt32(pswdChars.count)))]})
        return numTrain
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
    @IBAction func pushCancel(_ sender: UIBarButtonItem) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let sb = self.storyboard?.instantiateViewController(identifier: "CellTicketVC") as! CellTicketViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false)
    }
    @IBAction func infoSegmentControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            numDocumentText.isHidden = true
            notnumDocumentImage.isHidden = false
            linesImage.isHidden = true
            drinks1Image.isHidden = true
            drinks2Image.isHidden = true
            changed = 0
            priceP = price
            priceTicketLabel.text = NSString(format: "%.2f", priceP) as String
        }else if(sender.selectedSegmentIndex == 1){
            numDocumentText.isHidden = false
            notnumDocumentImage.isHidden = true
            linesImage.isHidden = true
            drinks1Image.isHidden = true
            drinks2Image.isHidden = true
            changed = 1
            priceCh = price - (price * 0.15)
            priceTicketLabel.text = NSString(format: "%.2f", priceCh) as String
        }else if(sender.selectedSegmentIndex == 2){
           numDocumentText.isHidden = false
            notnumDocumentImage.isHidden = true
            linesImage.isHidden = true
            drinks1Image.isHidden = true
            drinks2Image.isHidden = true
            changed = 2
            priceSd = price - (price * 0.5)
            priceTicketLabel.text = NSString(format: "%.2f", priceSd) as String
        }else{
            numDocumentText.isHidden = false
            notnumDocumentImage.isHidden = true
            linesImage.isHidden = true
            drinks1Image.isHidden = true
            drinks2Image.isHidden = true
            changed = 3
            pricePil = price - (price * 0.5)
            priceTicketLabel.text = NSString(format: "%.2f", pricePil) as String
        }
        
    }
   
    @IBAction func pushLines(_ sender: UIButton) {
        if(changed == 0){
            if(linesImage.isHidden){
                priceP = priceP + 50.00
            }else{
                priceP = priceP - 50.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceP) as String
        }else if(changed == 1){
            if(linesImage.isHidden){
                priceCh = priceCh + 50.00
            }else{
                priceCh = priceCh - 50.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceCh) as String
        }else if(changed == 2){
            if(linesImage.isHidden){
                priceSd = priceSd + 50.00
            }else{
                priceSd = priceSd - 50.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceSd) as String
        }else{
            if(linesImage.isHidden){
                pricePil = pricePil + 50.00
            }else{
                pricePil = pricePil - 50.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", pricePil) as String
        }
        linesImage.isHidden = !linesImage.isHidden
    }
    @IBAction func push1Drinks(_ sender: UIButton) {
        if(changed == 0){
            if(drinks1Image.isHidden){
                priceP = priceP + 20.00
            }else{
                priceP = priceP - 20.00
            }
            drinks1Image.isHidden = !drinks1Image.isHidden
            if(!drinks2Image.isHidden){
                priceP = priceP - 40.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceP) as String
        }else if(changed == 1){
            if(drinks1Image.isHidden){
                priceCh = priceCh + 20.00
            }else{
                priceCh = priceCh - 20.00
            }
            drinks1Image.isHidden = !drinks1Image.isHidden
            if(!drinks2Image.isHidden){
                priceCh = priceCh - 40.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceCh) as String
        }else if(changed == 2){
            if(drinks1Image.isHidden){
                priceSd = priceSd + 20.00
            }else{
                priceSd = priceSd - 20.00
            }
            drinks1Image.isHidden = !drinks1Image.isHidden
            if(!drinks2Image.isHidden){
                priceSd = priceSd - 40.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceSd) as String
        }else{
            if(drinks1Image.isHidden){
                pricePil = pricePil + 20.00
            }else{
                pricePil = pricePil - 20.00
            }
            drinks1Image.isHidden = !drinks1Image.isHidden
            if(!drinks2Image.isHidden){
                pricePil = pricePil - 40.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", pricePil) as String
        }
        drinks2Image.isHidden = true
            
    }
    @IBAction func push2Drinks(_ sender: UIButton) {
        if(changed == 0){
            if(drinks2Image.isHidden){
                priceP = priceP + 40.00
            }else{
                priceP = priceP - 40.00
            }
            if(!drinks1Image.isHidden){
                priceP = priceP - 20.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceP) as String
        }else if(changed == 1){
            if(drinks2Image.isHidden){
                priceCh = priceCh + 40.00
            }else{
                priceCh = priceCh - 40.00
            }
            if(!drinks1Image.isHidden){
                priceCh = priceCh - 20.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceCh) as String
        }else if(changed == 2){
            if(drinks2Image.isHidden){
                priceSd = priceSd + 40.00
            }else{
                priceSd = priceSd - 40.00
            }
            if(!drinks1Image.isHidden){
                priceSd = priceSd - 20.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", priceSd) as String
        }else{
            if(drinks2Image.isHidden){
                pricePil = pricePil + 40.00
            }else{
                pricePil = pricePil - 40.00
            }
            if(!drinks1Image.isHidden){
                pricePil = pricePil - 20.00
            }
            priceTicketLabel.text = NSString(format: "%.2f", pricePil) as String
        }
        drinks2Image.isHidden = !drinks2Image.isHidden
        drinks1Image.isHidden = true
    }
    func showAlertSuccess(){
        var pr: Double = 0.00
        var typeDocument: String = ""
        if(changed == 0){
            typeDocument = "Полный"
            pr = priceP
        }else if(changed == 1){
            typeDocument = "Детский"
            pr = priceCh
        }else if(changed == 2){
            typeDocument = "Студенческий"
            pr = priceSd
        }else{
            typeDocument = "Льготный"
            pr = pricePil
        }
        var numServer: Int = 0
        var server: String = "-"
        if(linesImage.isHidden == false && drinks1Image.isHidden == true && drinks2Image.isHidden == true){
            server = "постельное"
            numServer = 1
        }else if(linesImage.isHidden == false && drinks1Image.isHidden == false && drinks2Image.isHidden == true){
            server = "постельное, 1х чай"
            numServer = 4
        }else if(linesImage.isHidden == false && drinks1Image.isHidden == true && drinks2Image.isHidden == false){
            server = "постельноe, 2x чая"
            numServer = 5
        }else if(linesImage.isHidden == true && drinks1Image.isHidden == false && drinks2Image.isHidden == true){
            server = "1х чай"
            numServer = 2
        }else if(linesImage.isHidden == true && drinks1Image.isHidden == true && drinks2Image.isHidden == false){
            server = "2x чая"
            numServer = 3
        }
        // передача информации на сервер
        if(changed == 0){
            let urlInsertDocument = "http://localhost:3000/api/addPasDoc?doc_type=Полный&doc_num=-"
            let requestInsertDocumet = NSMutableURLRequest(url: URL(string: urlInsertDocument.encodeUrl)!)
            requestInsertDocumet.httpMethod = "POST"
            let taskInsertDocument = URLSession.shared.dataTask(with: requestInsertDocumet as URLRequest)
            taskInsertDocument.resume()
            
            let urlInsertPassenger = "http://localhost:3000/api/addPasInfo?pas_name=\(nameText.text!)&pas_surname=\(surnameText.text!)&pas_email=\(emailText.text!)"
            let requestInsertPassenger = NSMutableURLRequest(url: URL(string: urlInsertPassenger.encodeUrl)!)
            requestInsertPassenger.httpMethod = "POST"
            let taskInsertPassenger = URLSession.shared.dataTask(with: requestInsertPassenger as URLRequest)
            taskInsertPassenger.resume()
            
            let urlInsertTicket = "http://localhost:3000/api/addPasTic?tic_price=\(pr)&fl_id=\(fl_id)&r_st_begin=\(beginStation!)&r_st_end=\(endStation!)&tr_id=\(tr_id)&rc_num=\(numVagon!)&pl_num=\(numPlace!)&tic_num=\(numTrainCode!)"
            let requestInsertTicket = NSMutableURLRequest(url: URL(string: urlInsertTicket.encodeUrl)!)
            requestInsertTicket.httpMethod = "POST"
            let taskInsertTicket = URLSession.shared.dataTask(with: requestInsertTicket as URLRequest)
            taskInsertTicket.resume()
            if(numServer != 0){
                let urlInsertServer = "http://localhost:3000/api/addPasSer?num=\(numServer)"
                let requestInsertServer = NSMutableURLRequest(url: URL(string: urlInsertServer)!)
                requestInsertServer.httpMethod = "POST"
                let taskInsertServer = URLSession.shared.dataTask(with: requestInsertServer as URLRequest)
                taskInsertServer.resume()
            }
        }else if(changed == 1){
            let urlInsertDocument = "http://localhost:3000/api/addPasDoc?doc_type=Детский&doc_num=\(documentText.text!)"
            let requestInsertDocumet = NSMutableURLRequest(url: URL(string: urlInsertDocument.encodeUrl)!)
            requestInsertDocumet.httpMethod = "POST"
            let taskInsertDocument = URLSession.shared.dataTask(with: requestInsertDocumet as URLRequest)
            taskInsertDocument.resume()
            
            let urlInsertPassenger = "http://localhost:3000/api/addPasInfo?pas_name=\(nameText.text!)&pas_surname=\(surnameText.text!)&pas_email=\(emailText.text!)"
            let requestInsertPassenger = NSMutableURLRequest(url: URL(string: urlInsertPassenger.encodeUrl)!)
            requestInsertPassenger.httpMethod = "POST"
            let taskInsertPassenger = URLSession.shared.dataTask(with: requestInsertPassenger as URLRequest)
            taskInsertPassenger.resume()
            
            let urlInsertTicket = "http://localhost:3000/api/addPasTic?tic_price=\(pr)&fl_id=\(fl_id)&r_st_begin=\(beginStation!)&r_st_end=\(endStation!)&tr_id=\(tr_id)&rc_num=\(numVagon!)&pl_num=\(numPlace!)&tic_num=\(numTrainCode!)"
            let requestInsertTicket = NSMutableURLRequest(url: URL(string: urlInsertTicket.encodeUrl)!)
            requestInsertTicket.httpMethod = "POST"
            let taskInsertTicket = URLSession.shared.dataTask(with: requestInsertTicket as URLRequest)
            taskInsertTicket.resume()
            
            if(numServer != 0){
                let urlInsertServer = "http://localhost:3000/api/addPasSer?num=\(numServer)"
                let requestInsertServer = NSMutableURLRequest(url: URL(string: urlInsertServer)!)
                requestInsertServer.httpMethod = "POST"
                let taskInsertServer = URLSession.shared.dataTask(with: requestInsertServer as URLRequest)
                taskInsertServer.resume()
            }
        }else if(changed == 2){
            let urlInsertDocument = "http://localhost:3000/api/addPasDoc?doc_type=Студенческий&doc_num=\(documentText.text!)"
            let requestInsertDocumet = NSMutableURLRequest(url: URL(string: urlInsertDocument.encodeUrl)!)
            requestInsertDocumet.httpMethod = "POST"
            let taskInsertDocument = URLSession.shared.dataTask(with: requestInsertDocumet as URLRequest)
            taskInsertDocument.resume()
            
            let urlInsertPassenger = "http://localhost:3000/api/addPasInfo?pas_name=\(nameText.text!)&pas_surname=\(surnameText.text!)&pas_email=\(emailText.text!)"
            let requestInsertPassenger = NSMutableURLRequest(url: URL(string: urlInsertPassenger.encodeUrl)!)
            requestInsertPassenger.httpMethod = "POST"
            let taskInsertPassenger = URLSession.shared.dataTask(with: requestInsertPassenger as URLRequest)
            taskInsertPassenger.resume()
            
            let urlInsertTicket = "http://localhost:3000/api/addPasTic?tic_price=\(pr)&fl_id=\(fl_id)&r_st_begin=\(beginStation!)&r_st_end=\(endStation!)&tr_id=\(tr_id)&rc_num=\(numVagon!)&pl_num=\(numPlace!)&tic_num=\(numTrainCode!)"
            let requestInsertTicket = NSMutableURLRequest(url: URL(string: urlInsertTicket.encodeUrl)!)
            requestInsertTicket.httpMethod = "POST"
            let taskInsertTicket = URLSession.shared.dataTask(with: requestInsertTicket as URLRequest)
            taskInsertTicket.resume()
            
            if(numServer != 0){
                let urlInsertServer = "http://localhost:3000/api/addPasSer?num=\(numServer)"
                let requestInsertServer = NSMutableURLRequest(url: URL(string: urlInsertServer)!)
                requestInsertServer.httpMethod = "POST"
                let taskInsertServer = URLSession.shared.dataTask(with: requestInsertServer as URLRequest)
                taskInsertServer.resume()
            }
        }else{
            let urlInsertDocument = "http://localhost:3000/api/addPasDoc?doc_type=Льготный&doc_num=\(documentText.text!)"
            let requestInsertDocumet = NSMutableURLRequest(url: URL(string: urlInsertDocument.encodeUrl)!)
            requestInsertDocumet.httpMethod = "POST"
            let taskInsertDocument = URLSession.shared.dataTask(with: requestInsertDocumet as URLRequest)
            taskInsertDocument.resume()
            
            let urlInsertPassenger = "http://localhost:3000/api/addPasInfo?pas_name=\(nameText.text!)&pas_surname=\(surnameText.text!)&pas_email=\(emailText.text!)"
            let requestInsertPassenger = NSMutableURLRequest(url: URL(string: urlInsertPassenger.encodeUrl)!)
            requestInsertPassenger.httpMethod = "POST"
            let taskInsertPassenger = URLSession.shared.dataTask(with: requestInsertPassenger as URLRequest)
            taskInsertPassenger.resume()
            
            let urlInsertTicket = "http://localhost:3000/api/addPasTic?tic_price=\(pr)&fl_id=\(fl_id)&r_st_begin=\(beginStation!)&r_st_end=\(endStation!)&tr_id=\(tr_id)&rc_num=\(numVagon!)&pl_num=\(numPlace!)&tic_num=\(numTrainCode!)"
            let requestInsertTicket = NSMutableURLRequest(url: URL(string: urlInsertTicket.encodeUrl)!)
            requestInsertTicket.httpMethod = "POST"
            let taskInsertTicket = URLSession.shared.dataTask(with: requestInsertTicket as URLRequest)
            taskInsertTicket.resume()
            
            if(numServer != 0){
                let urlInsertServer = "http://localhost:3000/api/addPasSer?num=\(numServer)"
                let requestInsertServer = NSMutableURLRequest(url: URL(string: urlInsertServer)!)
                requestInsertServer.httpMethod = "POST"
                let taskInsertServer = URLSession.shared.dataTask(with: requestInsertServer as URLRequest)
                taskInsertServer.resume()
            }
        }
        let createPDF = CreatePDF()

        createPDF.numTicket = numTrainCode
        createPDF.dateAndTimeArr = dateArr
        createPDF.dateAndTimeSend = dateSend
        createPDF.surnameName = surnameText.text! + " " + nameText.text!
        createPDF.stationBegin = beginStation
        createPDF.stationEnd = endStation
        createPDF.numTrain = numTrain
        createPDF.numVagon = numVagon
        createPDF.numPlace = numPlace! + " " + typeDocument
        createPDF.typeServer = server
        createPDF.price = NSString(format: "%.2f", pr) as String
        let output = createPDF.render()
        let url = getDocumentsDirectory().appendingPathComponent("ticket.pdf")
        try? output.write(to: url)
        print(url)
        
        var emailAdress: String = ""
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user == nil{
                emailAdress = self.emailText.text!
            }else{
                let ref = Database.database().reference()
                ref.child("users/\(String(Auth.auth().currentUser!.uid))/email").observeSingleEvent(of: .value){(snapshot) in
                    emailAdress = (snapshot.value as? String)!
                }
            }
        }
        let fileData = NSData(contentsOf: url)
        let mail = sendMail(data: fileData! as Data, email: emailAdress)
        if(MFMailComposeViewController.canSendMail()){
            self.present(mail, animated: true, completion: nil)
        }else{
            print("Нет доступа")
        }
        
        
        let alert = UIAlertController(title: "Успешно!", message: "Билет оформлен. Электронный билет отправлен на почту\(emailAdress)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let sb = self.storyboard?.instantiateViewController(identifier: "MyTicketVC") as!MyTicketViewController
            sb.myTicketCellDataActual.append(MyTicketCellData(opened: false, numTicket: self.numTrainCode!, numTrain: self.numTrain!, direction: self.beginStation! + " - " + self.endStation!, dateSend: self.dateArr!, infoPlace: self.numPlace! + " место, " + self.numVagon! + " вагон", nameSurname: self.nameText.text! + "34 " + self.surnameText.text!, name: ["Отправление:","Прибытие:","Услуги:","Цена"], data: [self.dateArr!, self.dateSend!,server, NSString(format: "%.2f", pr) as String]))
            UserSettings.myTicketActual.append(contentsOf: sb.myTicketCellDataActual)
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false)
        }))
            self.present(alert, animated: false)
    }
    // отправить email на почту
    
    func sendMail(data: Data?, email: String)->MFMailComposeViewController{
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([email])
        mailComposer.setSubject("Покупка билетов")
        mailComposer.setMessageBody("Уважаемый пасажир!\n Вас приветствует ЖД вокзал.", isHTML: true)
        if let fileData = data{
            mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "ticket.pdf")
        }
        return mailComposer
    }
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    // проверка електронной почты
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func showAlertFailure(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func pushBuyTicket(_ sender: UIButton) {
        let surname = surnameText.text
        let name = nameText.text
        let document = documentText.text
        let email = emailText.text
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if(user == nil){
                if(self.changed != 0){
                    if(!surname!.isEmpty && !name!.isEmpty && !document!.isEmpty && !email!.isEmpty){
                        let t: Bool = self.isValidEmail(testStr: email!)
                        if(t){
                           self.showAlertSuccess()
                        }else{
                            self.showAlertFailure(message: "Неправельный email.")
                        }
                    }else{
                        self.showAlertFailure(message: "Заполните все поля")
                    }
                }else{
                    if(!surname!.isEmpty && !name!.isEmpty && !email!.isEmpty){
                        let t: Bool = self.isValidEmail(testStr: email!)
                        if(t){
                           self.showAlertSuccess()
                        }else{
                            self.showAlertFailure(message: "Неправельный email.")
                        }
                    }else{
                        self.showAlertFailure(message: "Заполните все поля")
                    }
                }
            }else{
                if(self.changed != 0){
                    if(!surname!.isEmpty && !name!.isEmpty && !document!.isEmpty){
                        self.showAlertSuccess()
                    }else{
                        self.showAlertFailure(message: "Заполните все поля")
                    }
                }else{
                    if(!surname!.isEmpty && !name!.isEmpty){
                        self.showAlertSuccess()
                    }else{
                        self.showAlertFailure(message: "Заполните все поля")
                    }
                }
            }
        }
    }
    
}
