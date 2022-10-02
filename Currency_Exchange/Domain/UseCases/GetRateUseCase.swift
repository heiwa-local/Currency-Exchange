//
//  GetCurrencyExchangeByParamsUseCase.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation

class GetRateUseCase {
    private let repository = RateRepository()
    var rates: [String: Double] = [:]
    
    func execute (to: String, from: String, amount: Double, complition: @escaping([String: Double]) -> Void) {
        repository.getRate(to: to, from: from, amount: amount){ result in
            self.rates[result.query.to] = result.result
        }
        complition(rates)
    }
}
