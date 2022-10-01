//
//  GetAllRatesNames.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class GetCurrenciesNamesUseCase {
    private let repository = SymbolsResponseRepository()
    
    func execute(complition: @escaping((CurrenciesNames) -> Void )) {
        repository.getCurrenciesNames(){ data in
            complition(data)
        }
    }
}
