//
//  CurrencyExchangeResultRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 18.08.2022.
//

import Foundation
import RxSwift

class CurrencyConvertRepository {
    let currencyExchangeAPI = CurrencyExchangeAPI()
    
    func getRate(to: String, from: String, amount: Double, complition: @escaping((ConvertResponseModel) -> Void)) {
        
        currencyExchangeAPI.getRate(to: to, from: from, amount: amount) { result in
            do {
                let responce = try JSONDecoder().decode(ConvertResponseModel.self, from: result)
                complition(responce)
            }
            catch {
                print("Error in repository")
            }
        }
    }
}
