//
//  GetCurrencyExchangeByParamsUseCase.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation

class GetCurrencyExchangeByParamsUseCase {
    private let currencyExchangeRepository: CurrencyConvertRepository
    
    init(currencyExchangeRepository: CurrencyConvertRepository) {
        self.currencyExchangeRepository = currencyExchangeRepository
    }
    
//    func execute (currencyExchangeQuery: CurrencyExchangeQuery,
//                  complition: @escaping(ConvertResponseModel) -> Void) {
//        
//        currencyExchangeRepository.getCurrenctExchangeByParams(currencyExchangeQuery: currencyExchangeQuery,
//                                                                      complition: {result in
//            complition(result)
//        })
//        
//    }
}
