//
//  CurrencyListController.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class CurrencyListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let viewModel: CurrencyListViewModel = CurrencyListViewModel()
    private let disposeBag = DisposeBag()
    
    var searchActive = true
    var editActive = false

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var currencyTable: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    var currenciesRates: [String: Double] = [:]
    var curenciesNames: [String: String] = [:]
    var filteredCurrenciesRates: [String: Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency"
        
        popUpView.center = view.center
        searchBar.delegate = self
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBaseRate))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchRates))
        navigationItem.rightBarButtonItems = [edit]
        navigationItem.leftBarButtonItems = [search]
        
        viewModel.obsRates.asObservable().subscribe(onNext: { [weak self] result in
            self?.currenciesRates = result
            self?.filteredCurrenciesRates = result
            DispatchQueue.main.async {
                self?.currencyTable.reloadData()
            }
        }).disposed(by: disposeBag)
                
        viewModel.obsCurrenciesNames.asObservable().subscribe(onNext: { [weak self] result in
            self?.curenciesNames = result
            DispatchQueue.main.async {
                self?.currencyTable.reloadData()
            }
        }).disposed(by: disposeBag)
        
        filteredCurrenciesRates = currenciesRates
        
        viewModel.getRatesNames()
        viewModel.getRatesList(base: "USD")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrenciesRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListViewCell
        cell.currencyName.text = curenciesNames[String(Array(filteredCurrenciesRates)[indexPath.row].key)]
        cell.currencyValue.text = String(Array(filteredCurrenciesRates)[indexPath.row].value)
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBaseRate))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchRates))
        navigationItem.rightBarButtonItems = [edit]
        navigationItem.leftBarButtonItems = [search]
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredCurrenciesRates = searchText.isEmpty ? self.currenciesRates : self.currenciesRates.filter({$0.key.prefix(searchText.count) == searchText})
        
        currencyTable.reloadData()
    }
    
    
    
    @objc func editBaseRate(){
        
        if (editActive) {
            popUpView.removeFromSuperview()
        }
        else{
            self.view.addSubview(popUpView)
        }
        self.editActive = !self.editActive

    }
    
    @objc func searchRates(){
        navigationItem.leftBarButtonItems?.removeAll()
        navigationItem.rightBarButtonItems?.removeAll()
        
        navigationItem.titleView = searchBar
    }
}
