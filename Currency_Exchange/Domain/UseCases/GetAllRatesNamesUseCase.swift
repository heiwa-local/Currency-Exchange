//
//  GetAllRatesNames.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class GetAllRatesNamesUseCase {
    private let repository = SymbolsResponseRepository()
    
    func execute(complition: @escaping((SymbolsResponseModel) -> Void )) {
        repository.fetchSymbolsResponce(){ data in
            complition(data)
        }
    }
}
