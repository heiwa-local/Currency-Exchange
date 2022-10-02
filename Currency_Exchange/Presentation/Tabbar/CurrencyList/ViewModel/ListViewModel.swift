//
//  CurrencyListViewModel.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation
import RxSwift
import RxRelay

class ListViewModel {

    let getAllRatesUseCase = GetAllRatesUseCase()
    let getAllRatesNamesUseCase = GetCurrenciesNamesUseCase()
    
    let obsRates = PublishRelay<[String: Double]>()
    let obsCurrenciesNames = PublishRelay<[String: String]>()
        
    func getAllRates(base rate: String){
        getAllRatesUseCase.execute(base: rate){ data in
            self.obsRates.accept(data)
        }
    }
    
    func getCurrenciesNames() {
        getAllRatesNamesUseCase.execute() { data in
            self.obsCurrenciesNames.accept(data)
        }
    }
}
