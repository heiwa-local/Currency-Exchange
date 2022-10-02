//
//  GetAllRates.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class GetAllRatesUseCase {
    private let repository = RatesRepository()
    
    func execute (base rate: String, complition: @escaping(([String: Double]) -> Void)) {
        repository.getAllRates(base: rate) {result in
            complition(result.rates)
        }
    }
}
