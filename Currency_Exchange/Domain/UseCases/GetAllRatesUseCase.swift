//
//  GetAllRates.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class GetAllRatesUseCase {
    private let repository = DataResponseRepository()
    
    func execute (base rate: String, complition: @escaping((DataResponseModel) -> Void)) {
        repository.fetchDataResponce(base: rate) {result in
            complition(result)
        }
    }
}
