//
//  DataResponceRepository.swift
//  Currency_Exchange
//
//  Created by kunari on 24.08.2022.
//

import Foundation

class DataResponseRepository {
    private let currencyExchangeAPI: CurrencyExchangeAPI = CurrencyExchangeAPI()
        
    func fetchDataResponce(base: String, complition: @escaping((DataResponseModel) -> Void)){
        currencyExchangeAPI.fetchDataResponse(base: base){ result in
            do{
                let response = try JSONDecoder().decode(DataResponseModel.self, from: result)
                complition(response)
            } catch {
                print("Error in repository func")
            }
        }
    }
}
