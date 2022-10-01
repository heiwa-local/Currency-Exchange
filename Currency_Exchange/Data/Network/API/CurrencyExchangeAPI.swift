//
//  CurrencyExchangeAPI.swift
//  Currency_Exchange
//
//  Created by kunari on 15.08.2022.
//

import Foundation

//zuN0uFpvUqZMcI11wU50fCwU0w3GzZHb

final class CurrencyExchangeAPI {
    private let apiKey = "zuN0uFpvUqZMcI11wU50fCwU0w3GzZHb"

    func getCurrenciesNames (complition: @escaping((Data) -> Void)) {
        let url = "https://api.apilayer.com/exchangerates_data/symbols"
        fetchData(url: url) { responce in
            complition(responce)
        }
    }
    
    func getRate(to: String, from: String, amount: Double, complition: @escaping((Data) -> Void)){
        let url = "https://api.apilayer.com/exchangerates_data/convert?to=\(to)&from=\(from)&amount=\(amount)"
        fetchData(url: url) { responce in
            complition(responce)
        }
    }
    
    func getAllRates (base: String, complition: @escaping((Data) -> Void)) {
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let formattedDate = formatter.string(from: date)
        
        let formattedDate = "2022-08-24"
        
        let url = "https://api.apilayer.com/exchangerates_data/\(formattedDate)&base=\(base)"
        fetchData(url: url) { responce in
            complition(responce)
        }
        
    }
    
    private func fetchData(url: String, complition: @escaping((Data) -> Void)){
        let semaphore = DispatchSemaphore (value: 0)

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
