//
//  NetworkService.swift
//  TrainIOSApplication
//
//  Created by Тимофей on 12.05.2020.
//  Copyright © 2020 Тимофей. All rights reserved.
//

import Foundation

class NetworkService{
   func requestInfoFlight(urlString: String, completion: @escaping (Result<[InfoFlight], Error>)->Void){
    guard let url = URL(string: urlString.encodeUrl) else { return }
    URLSession.shared.dataTask(with: url){ (data, response, error) in
               DispatchQueue.main.async {
                   if error != nil{
                       print("Some error")
                       completion(.failure(error!))
                       return
                   }
                   guard data == data else {return}
                   do{
                       let decoder = JSONDecoder()
                       let flights = try decoder.decode([InfoFlight].self, from: data!)
                       completion(.success(flights))
                   }catch let jsonError{
                       print("Failed to decode JSON", jsonError)
                       completion(.failure(jsonError))
                   }
               }
           }.resume()
    }
    
    func requestAllStation(urlString: String, completion: @escaping (Result<[AllStation], Error>)->Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    print("Some error")
                    completion(.failure(error!))
                    return
                }
                guard data == data else {return}
                do{
                    let decoder = JSONDecoder()
                    let flights = try decoder.decode([AllStation].self, from: data!)
                    completion(.success(flights))
                }catch let jsonError{
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }

    func requestAllVagonFlight(urlString: String, completion: @escaping (Result<[AllVagonFlight], Error>)->Void){
        guard let url = URL(string: urlString.encodeUrl) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    print("Some error")
                    completion(.failure(error!))
                    return
                }
                guard data == data else {return}
                do{
                    let decoder = JSONDecoder()
                    let flights = try decoder.decode([AllVagonFlight].self, from: data!)
                    completion(.success(flights))
                }catch let jsonError{
                    print("Failed to decode JSON1", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func requestRoute(urlString: String, completion: @escaping (Result<[Route], Error>)->Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    print("Some error")
                    completion(.failure(error!))
                    return
                }
                guard data == data else {return}
                do{
                    let decoder = JSONDecoder()
                    let flights = try decoder.decode([Route].self, from: data!)
                    completion(.success(flights))
                }catch let jsonError{
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func requestReservedPlace(urlString: String, completion: @escaping (Result<[ReservedPlace], Error>)->Void){
        guard let url = URL(string: urlString.encodeUrl) else { return }
          URLSession.shared.dataTask(with: url){ (data, response, error) in
              DispatchQueue.main.async {
                  if error != nil{
                      print("Some error")
                      completion(.failure(error!))
                      return
                  }
                  guard data == data else {return}
                  do{
                      let decoder = JSONDecoder()
                      let flights = try decoder.decode([ReservedPlace].self, from: data!)
                      completion(.success(flights))
                  }catch let jsonError{
                      print("Failed to decode JSON", jsonError)
                      completion(.failure(jsonError))
                  }
              }
          }.resume()
      }
    
    func requestNumVagon(urlString: String, completion: @escaping (Result<[NumVagon], Error>)->Void){
        guard let url = URL(string: urlString.encodeUrl) else { return }
          URLSession.shared.dataTask(with: url){ (data, response, error) in
              DispatchQueue.main.async {
                  if error != nil{
                      print("Some error")
                      completion(.failure(error!))
                      return
                  }
                  guard data == data else {return}
                  do{
                      let decoder = JSONDecoder()
                        let flights = try decoder.decode([NumVagon].self, from: data!)
                      completion(.success(flights))
                  }catch let jsonError{
                      print("Failed to decode JSON", jsonError)
                      completion(.failure(jsonError))
                  }
              }
          }.resume()
      }
    
    func requestReturnTicket(urlString: String, completion: @escaping (Result<[ReturnTicket], Error>)->Void){
    guard let url = URL(string: urlString.encodeUrl) else { return }
    URLSession.shared.dataTask(with: url){ (data, response, error) in
               DispatchQueue.main.async {
                   if error != nil{
                       print("Some error")
                       completion(.failure(error!))
                       return
                   }
                   guard data == data else {return}
                   do{
                       let decoder = JSONDecoder()
                       let flights = try decoder.decode([ReturnTicket].self, from: data!)
                       completion(.success(flights))
                   }catch let jsonError{
                       print("Failed to decode JSON", jsonError)
                       completion(.failure(jsonError))
                   }
               }
           }.resume()
    }

}
extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
