//
//  GetAllRatesNames.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class GetCurrenciesNamesUseCase {
    private let repository = CurrenciesNamesRepository()
    
    func execute(complition: @escaping(([String: String]) -> Void )) {
        repository.getCurrenciesNames(){ data in
            complition(data.symbols)
        }
    }
}
