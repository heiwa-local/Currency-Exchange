//
//  CurrencyConverterViewModel.swift
//  Currency_Exchange
//
//  Created by kunari on 01.10.2022.
//

import Foundation
import RxRelay

class ConverterViewModel {
    let getAllRatesNamesUseCase = GetCurrenciesNamesUseCase()
    let getRateUseCase = GetRateUseCase()
    
    var rates: [String: Double] = [:]
    let obsRates = PublishRelay<[String: Double]>()
    let obsCurrenciesNames = PublishRelay<[String: String]>()
    
    func getCurrenciesNames() {
        getAllRatesNamesUseCase.execute() { data in
            self.obsCurrenciesNames.accept(data)
        }
    }
    
    func getRate(to: String, from: String, amount: Double){
        getRateUseCase.execute(to: to, from: from, amount: amount){ data in
            self.rates = data
        }
        self.obsRates.accept(rates)
    }
}
