//
//  CurrencyExchangeResult.swift
//  Currency_Exchange
//
//  Created by kunari on 18.08.2022.
//

import Foundation

struct ConvertResponseModel: Codable{
    var success: Bool
    var query: CurrencyExchangeQuery
    var info: CurrencyExchangeInfo
    var date: String
    var result: Double
    
    mutating func setData(currencyExchangeResult: ConvertResponseModel) {
        self.success = currencyExchangeResult.success
        self.query = currencyExchangeResult.query
        self.info = currencyExchangeResult.info
        self.date = currencyExchangeResult.date
        self.result = currencyExchangeResult.result
        
    }
}

struct CurrencyExchangeQuery: Codable {
    let from: String
    let to: String
    let amount: Double
}

struct CurrencyExchangeInfo: Codable {
    let timestamp: Int
    let rate: Double
}
