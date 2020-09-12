//
//  ticketFormPDF.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 30.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import Foundation
import PDFKit

class CreatePDF{

    var numTicket: String?
    var dateAndTimeSend: String?
    var surnameName: String?
    var stationBegin: String?
    var stationEnd: String?
    var dateAndTimeArr: String?
    var numTrain: String?
    var numVagon: String?
    var numPlace: String?
    var typeServer: String?
    var price: String?
    
    func render() -> Data {
        let pageRect = CGRect(x: 0, y: 0, width: 792, height: 612)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)

        return renderer.pdfData { ctx in
            ctx.beginPage()
            // квадрат
            ctx.cgContext.move(to: CGPoint(x: 50, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 50))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 562))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 350))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 350))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 562))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 562))
            
            ctx.cgContext.move(to: CGPoint(x: 262, y: 350))
            ctx.cgContext.addLine(to: CGPoint(x: 262, y: 562))
            
            ctx.cgContext.move(to: CGPoint(x: 742, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 562))
            // горизонтальные линии
            ctx.cgContext.move(to: CGPoint(x: 50, y: 125))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 125))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 175))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 175))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 200))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 225))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 250))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 275))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 275))
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 742, y: 300))
            // верникальные линии
            // 1 линия
            ctx.cgContext.move(to: CGPoint(x: 125, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 125, y: 125))
            
            ctx.cgContext.move(to: CGPoint(x: 425, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 425, y: 125))
            // 2 линия
            ctx.cgContext.move(to: CGPoint(x: 125, y: 125))
            ctx.cgContext.addLine(to: CGPoint(x: 125, y: 175))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 125))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 175))
            // 3 линия
            ctx.cgContext.move(to: CGPoint(x: 232, y: 175))
            ctx.cgContext.addLine(to: CGPoint(x: 232, y: 200))
            
            ctx.cgContext.move(to: CGPoint(x: 450, y: 175))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 200))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 175))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 200))
            // 4 линия
            ctx.cgContext.move(to: CGPoint(x: 232, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 232, y: 225))
            
            ctx.cgContext.move(to: CGPoint(x: 450, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 225))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 225))
            // 5 линия
            ctx.cgContext.move(to: CGPoint(x: 232, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 232, y: 250))
            
            ctx.cgContext.move(to: CGPoint(x: 450, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 250))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 225))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 250))
            // 6 линия
            ctx.cgContext.move(to: CGPoint(x: 232, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 232, y: 275))
            
            ctx.cgContext.move(to: CGPoint(x: 450, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 275))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 250))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 275))
            // 7 линия
            ctx.cgContext.move(to: CGPoint(x: 232, y: 275))
            ctx.cgContext.addLine(to: CGPoint(x: 232, y: 300))
            
            ctx.cgContext.move(to: CGPoint(x: 450, y: 275))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 300))
            
            ctx.cgContext.move(to: CGPoint(x: 565, y: 275))
            ctx.cgContext.addLine(to: CGPoint(x: 565, y: 300))

            ctx.cgContext.setLineCap(.square)
            ctx.cgContext.strokePath()

                // рисуем Посадочный документ
            let gridLetterFont = UIFont.systemFont(ofSize: 25)
            let gridLetterStyle = NSMutableParagraphStyle()
            gridLetterStyle.alignment = .left

            let gridLetterAttributes: [NSAttributedString.Key: Any] = [
                .font: gridLetterFont,
                .paragraphStyle: gridLetterStyle
            ]
            var cellRect = CGRect(x: 142, y:75 , width: 400, height: 30)
            String("Посадочный документ").draw(in: cellRect, withAttributes: gridLetterAttributes)
                // рисуем номер билета
            let gridLetterFontNumTicket = UIFont.systemFont(ofSize: 20)
            let gridLetterStyleNumTicket = NSMutableParagraphStyle()
            gridLetterStyleNumTicket.alignment = .left
            
            let gridLetterAttributesNumTicket: [NSAttributedString.Key: Any] = [
                .font: gridLetterFontNumTicket,
                .paragraphStyle: gridLetterStyleNumTicket
            ]
            
            cellRect = CGRect(x: 430, y:80 , width: 400, height: 30)
            String("Номер билета: \(numTicket!)").draw(in: cellRect, withAttributes: gridLetterAttributesNumTicket)
        
            // МПС
            cellRect = CGRect(x: 67, y:137 , width: 100, height: 30)
            String("МПС").draw(in: cellRect, withAttributes: gridLetterAttributesNumTicket)
            // Этот посадочный билет является основанием для посадки
            let gridLetterStyleCon = NSMutableParagraphStyle()
            gridLetterStyleCon.alignment = .center
            
            let gridLetterAttributesCon: [NSAttributedString.Key: Any] = [
                .font: gridLetterFontNumTicket,
                .paragraphStyle: gridLetterStyleCon
            ]
            cellRect = CGRect(x: 130, y:127 , width: 433, height: 60)
            String("Этот посадочный билет является основанием \n для посадки").draw(in: cellRect, withAttributes: gridLetterAttributesCon)
            // информация про рейс
            let gridLetterFontInfo = UIFont.systemFont(ofSize: 14)
            let gridLetterStyleInfo = NSMutableParagraphStyle()
            gridLetterStyleInfo.alignment = .left
            
            let gridLetterAttributesInfo: [NSAttributedString.Key: Any] = [
                .font: gridLetterFontInfo,
                .paragraphStyle: gridLetterStyleInfo
            ]
            cellRect = CGRect(x: 570, y:139 , width: 200, height: 20)
            String("\(dateAndTimeArr!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            // 1 столбец
            cellRect = CGRect(x: 51, y:180 , width: 200, height: 20)
            String("Фамилия. Имя").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 51, y:205 , width: 200, height: 20)
            String("Станция отправления").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 51, y:230 , width: 200, height: 20)
            String("Станция прибытия").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 51, y:255 , width: 200, height: 20)
            String("Дата и время отправления").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 51, y:280 , width: 200, height: 20)
            String("Дата и время прибытия").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            //2 столбец
            cellRect = CGRect(x: 235, y:180 , width: 200, height: 20)
            String("\(surnameName!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 235, y:205 , width: 200, height: 20)
            String("\(stationBegin!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 235, y:230 , width: 200, height: 20)
            String("\(stationEnd!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 235, y:255 , width: 200, height: 20)
            String("\(dateAndTimeArr!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 235, y:280 , width: 200, height: 20)
            String("\(dateAndTimeSend!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            // 3 столбец
            cellRect = CGRect(x: 455, y:180 , width: 200, height: 20)
            String("Поезд").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 455, y:205 , width: 200, height: 20)
            String("Вагон").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 455, y:230 , width: 200, height: 20)
            String("Место").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 455, y:255 , width: 200, height: 20)
            String("Сервис").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            // 4 столбец
            cellRect = CGRect(x: 570, y:180 , width: 200, height: 20)
            String("\(numTrain!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 570, y:205 , width: 200, height: 20)
            String("\(numVagon!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 570, y:230 , width: 200, height: 20)
            String("\(numPlace!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            
            cellRect = CGRect(x: 570, y:255 , width: 200, height: 20)
            String("\(typeServer!)").draw(in: cellRect, withAttributes: gridLetterAttributesInfo)
            // Цена
            cellRect = CGRect(x: 60, y:315 , width: 200, height: 30)
            String("Цена = \(price!)").draw(in: cellRect, withAttributes: gridLetterAttributesNumTicket)
            // картинка
            cellRect = CGRect(x: 51, y: 51, width: 73, height: 73)
            UIImage(imageLiteralResourceName: "download.jpg").draw(in: cellRect)
            // qr-code
            let gridLetterFontqr = UIFont.systemFont(ofSize: 10)
            let gridLetterStyleqr = NSMutableParagraphStyle()
            gridLetterStyleqr.alignment = .left
                       
            let gridLetterAttributesqr: [NSAttributedString.Key: Any] = [
                .font: gridLetterFontqr,
                .paragraphStyle: gridLetterStyleqr
            ]
            cellRect = CGRect(x: 270, y:425 , width: 600, height: 100)
            String("Этот посадочный документ является основанием для проезда без обращения в кассу.\nПосадочный документ является расчетным документом.\nВозвращение данного посадочного документа возможно до отправления поезда.").draw(in: cellRect, withAttributes: gridLetterAttributesqr)
            
            if let myString = ("\(numTicket!)\n\(stationBegin!)-\(dateAndTimeArr!)\n\(stationEnd!)-\(dateAndTimeSend!)\n\(numTrain!)\n\(numVagon!)\n\(numPlace!)" as NSString).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
                let data = myString.data(using: .ascii, allowLossyConversion: false)
                let filter = CIFilter(name: "CIQRCodeGenerator")
                filter?.setValue(data, forKey: "InputMessage")
                    
                let ciImage = filter?.outputImage
                
                let  transform = CGAffineTransform(scaleX: 30, y: 30)
                let transformImage = ciImage?.transformed(by: transform)
                
                cellRect = CGRect(x: 50, y: 351, width: 210, height: 210)
                UIImage(ciImage: transformImage!).draw(in: cellRect)
            }
        }
    }
}
