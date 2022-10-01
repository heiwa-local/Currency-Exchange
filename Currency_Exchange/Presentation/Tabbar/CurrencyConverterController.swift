//
//  CurrencyConverterController.swift
//  Currency_Exchange
//
//  Created by kunari on 21.08.2022.
//

import Foundation
import UIKit
import RxRelay
import RxSwift

class CurrencyConverterController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baseCurrencyButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var addCurrencyButton: UIButton!
    
    private let viewModel: CurrencyConverterViewModel = CurrencyConverterViewModel()
    private let disposeBag = DisposeBag()
    
    var rates: [String: Double] = [:]
    var baseCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Converter"
        tableView.reloadData()
        
        convertButton.addTarget(self, action: #selector(convert), for: .touchUpInside)
        addCurrencyButton.addTarget(self, action: #selector(addCurrency), for: .touchUpInside)
        
        baseCurrencyButton.setTitle(baseCurrency, for: .normal)
        
        viewModel.obsCurrenciesNames.asObservable().subscribe(onNext: {[weak self] result in
            var baseItemList: [UIAction] = []
            for i in result{
                let item = UIAction(title: i.value){_ in
                    self?.baseCurrency = i.key
                    
                    for (currencyName, _) in self!.rates{
                        self?.viewModel.getRate(to: currencyName, from: i.key, amount: Double(self?.valueTextField.text ?? "1") ?? 1)
                    }
                    
                    DispatchQueue.main.async {
                        self?.baseCurrencyButton.setTitle(self?.baseCurrency, for: .normal)
                    }
                }
                baseItemList.append(item)
            }
            DispatchQueue.main.async {
                self?.baseCurrencyButton.menu = UIMenu(title: "Choose currency",children: baseItemList)
            }

        }).disposed(by: disposeBag)
        
        viewModel.obsRates.asObservable().subscribe(onNext: {[weak self] result in
            self?.rates = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
        viewModel.getRatesNames()
        viewModel.getRate(to: "RUB", from: "USD", amount: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellConverter", for: indexPath) as! CurrencyConverterViewCell
        cell.currencyNameLabel.text = String(Array(rates)[indexPath.row].key)
        cell.currencyValueLabel.text = String(Array(rates)[indexPath.row].value)
        return cell
    }
    
    @objc func convert (){
        for (currencyName, _) in rates{
            viewModel.getRate(to: currencyName, from: baseCurrency, amount: Double(valueTextField.text ?? "1") ?? 1)
        }
        tableView.reloadData()
    }
    
    @objc func addCurrency (){
        
    }
}
