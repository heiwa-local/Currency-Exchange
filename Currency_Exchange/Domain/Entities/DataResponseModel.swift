//
//  DataResponseModel.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

struct DataResponseModel: Codable {
    let base: String
    let date: String
    let historical: Bool
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
    
    init() {
        self.base = ""
        self.date = ""
        self.historical = false
        self.rates = [:]
        self.success = false
        self.timestamp = 0
    }
}
