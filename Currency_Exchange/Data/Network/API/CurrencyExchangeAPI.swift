//
//  CurrencyExchangeAPI.swift
//  Currency_Exchange
//
//  Created by kunari on 15.08.2022.
//

import Foundation
import RxSwift
import RxRelay

//zuN0uFpvUqZMcI11wU50fCwU0w3GzZHb

final class CurrencyExchangeAPI {
    private let apiKey = "ngbut1zIcVpnJc3hR3DZwWeIHmVvGs26"
    
//    func getData(currencyExchangeQuery: CurrencyExchangeQuery, complition: @escaping((CurrencyConvert) -> Void)) {
//        let semaphore = DispatchSemaphore (value: 0)
//
//        let url = "https://api.apilayer.com/exchangerates_data/convert?to=\(currencyExchangeQuery.to)&from=\(currencyExchangeQuery.from)&amount=\(currencyExchangeQuery.amount)"
//
//        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
//
//        request.httpMethod = "GET"
//        request.addValue("zuN0uFpvUqZMcI11wU50fCwU0w3GzZHb", forHTTPHeaderField: "apikey")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            return
//          }
//            do {
//                let currencyExchange = try JSONDecoder().decode(CurrencyConvert.self, from: data)
//                complition(currencyExchange)
//            } catch {
//                print(error.localizedDescription)
//            }
////          print(String(data: data, encoding: .utf8)!)
//          semaphore.signal()
//        }
////        return currencyExchange
//        task.resume()
//        semaphore.wait()
//    }
    
    func fetchSymbolsResponse (complition: @escaping((Data) -> Void)) {
        let semaphore = DispatchSemaphore (value: 0)

        let url = "https://api.apilayer.com/exchangerates_data/symbols"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            complition(data)
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func fetchDataResponse (base: String, complition: @escaping((Data) -> Void)) {
        let semaphore = DispatchSemaphore (value: 0)
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let formattedDate = formatter.string(from: date)
        
        let formattedDate = "2022-08-24"
        
        let url = "https://api.apilayer.com/exchangerates_data/\(formattedDate)&base=\(base)"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            complition(data)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
