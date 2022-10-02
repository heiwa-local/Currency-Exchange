//
//  SymbolsResponseRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 23.08.2022.
//

import Foundation

class CurrenciesNamesRepository {
    private let currencyExchangeAPI: CurrencyExchangeAPI = CurrencyExchangeAPI()
    
    func getCurrenciesNames(complition: @escaping((CurrenciesNames) -> Void)) {
        currencyExchangeAPI.getCurrenciesNames() { result in
            do {
                let response = try JSONDecoder().decode(CurrenciesNames.self, from: result)
                complition(response)
            } catch {
                print("Error in repository")
            }
        }
    }
}
