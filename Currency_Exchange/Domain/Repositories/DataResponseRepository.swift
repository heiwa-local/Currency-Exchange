//
//  DataResponceRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class DataResponseRepository {
    private let currencyExchangeAPI: CurrencyExchangeAPI = CurrencyExchangeAPI()
        
    func getAllRates(base: String, complition: @escaping((Rates) -> Void)){
        currencyExchangeAPI.getAllRates(base: base){ result in
            do{
                let response = try JSONDecoder().decode(Rates.self, from: result)
                complition(response)
            } catch {
                print("Error in repository func")
            }
        }
    }
}
