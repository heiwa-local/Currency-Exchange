//
//  CurrencyExchangeResultRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 18.08.2022.
//

import Foundation
import RxSwift

class RateRepository {
    let currencyExchangeAPI = CurrencyExchangeAPI()
    
    func getRate(to: String, from: String, amount: Double, complition: @escaping((Rate) -> Void)) {
        
        currencyExchangeAPI.getRate(to: to, from: from, amount: amount) { result in
            do {
                let responce = try JSONDecoder().decode(Rate.self, from: result)
                complition(responce)
            }
            catch {
                print("Error in repository")
            }
        }
    }
}
