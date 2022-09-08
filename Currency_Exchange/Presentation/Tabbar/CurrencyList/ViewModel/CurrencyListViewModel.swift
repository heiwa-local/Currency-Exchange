//
//  CurrencyListViewModel.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation
import RxSwift
import RxRelay

class CurrencyListViewModel {

    let getAllRatesUseCase = GetAllRatesUseCase()
    let getAllRatesNamesUseCase = GetAllRatesNamesUseCase()
    
    let obsRates = PublishRelay<[String: Double]>()
    let obsCurrenciesNames = PublishRelay<[String: String]>()
    
//    let currencySymbols = SymbolsResponseModel.init()
    
    func getRatesList(base rate: String){
        getAllRatesUseCase.execute(base: rate){ data in
            self.obsRates.accept(data.rates)
        }
    }
    
    func getRatesNames() {
        getAllRatesNamesUseCase.execute() { data in
            self.obsCurrenciesNames.accept(data.symbols)
        }
    }
}
