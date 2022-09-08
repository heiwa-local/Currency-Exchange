//
//  SymbolsResponseRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 23.08.2022.
//

import Foundation

class SymbolsResponseRepository {
    private let currencyExchangeAPI: CurrencyExchangeAPI = CurrencyExchangeAPI()
    
    func fetchSymbolsResponce(complition: @escaping((SymbolsResponseModel) -> Void)) {
        currencyExchangeAPI.fetchSymbolsResponse() { result in
            do {
                let response = try JSONDecoder().decode(SymbolsResponseModel.self, from: result)
                complition(response)
            } catch {
                print("Error in repository")
            }
        }
    }
}
