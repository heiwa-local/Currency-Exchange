//
//  MainViewModel.swift
//  Currency_Exchange
//
//  Created by kunari on 15.08.2022.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    
    let currencyExchangeResultRepository: CurrencyConvertRepository = CurrencyConvertRepository()
    
    let currencyExchangeResult = PublishRelay<ConvertResponseModel>()
    
//    func getCurrenctExchangeByParams(from: String, to: String, amount: Double){
//
//        let currencyExchangeQuery: CurrencyExchangeQuery = CurrencyExchangeQuery(from: from, to: to, amount: amount)
//
//        currencyExchangeResultRepository.getCurrenctExchangeByParams(currencyExchangeQuery: currencyExchangeQuery) { result in
//            self.currencyExchangeResult.accept(result)
//        }
//    }

}
