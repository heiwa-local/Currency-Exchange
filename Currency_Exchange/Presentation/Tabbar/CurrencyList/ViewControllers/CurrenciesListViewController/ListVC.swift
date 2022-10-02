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

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let viewModel: ListViewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    
    var searchActive = true
    var editActive = false
    var baseCurrency = "USD"
    var pickerBaseCurrency = "USD"

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var currenciesPickerView: UIPickerView!
    @IBOutlet weak var confirmPopUpButton: UIButton!
    @IBOutlet weak var closePopUpButton: UIButton!
    
//    var currenciesNamesArray: [String] = []
    var currenciesRates: [String: Double] = [:]
    var curenciesNames: [String: String] = [:]
    var filteredCurrenciesRates: [String: Double] = [:]
    
//    var label: UILabel {
//        let label = UILabel(frame: currencyTable.bounds)
//        label.text = "No data"
//        return label
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency"
        
//        currencyTable.backgroundView = UIView(frame: currencyTable.bounds)
//        currencyTable.backgroundView?.addSubview(label)
//        label.center = currencyTable.center
        
        self.confirmPopUpButton.addTarget(self, action: #selector(confirmChanges), for: .touchDown)
        self.closePopUpButton.addTarget(self, action: #selector(closePopUp), for: .touchDown)
        
        self.popUpView.center.x = view.center.x
        self.popUpView.center.y = 0
        self.popUpView.alpha = 0
        self.popUpView.layer.cornerRadius = 10
        self.view.addSubview(popUpView)
        
        self.currenciesPickerView.delegate = self
        self.currenciesPickerView.dataSource = self
        
        searchBar.delegate = self
        self.searchBar.alpha = 0
        searchBar.searchTextField.textColor = .white
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBaseRate))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchRates))

        navigationItem.rightBarButtonItems = [search, edit]
        
        viewModel.obsRates.asObservable().subscribe(onNext: { [weak self] result in
            self?.currenciesRates = result
            self?.filteredCurrenciesRates = result
            DispatchQueue.main.async {
                self?.currencyTable.reloadData()
            }
        }).disposed(by: disposeBag)

        viewModel.obsCurrenciesNames.asObservable().subscribe(onNext: { [weak self] result in
            self?.curenciesNames = result
//            self?.currenciesNamesArray = Array(result.keys)
            DispatchQueue.main.async {
                self?.currencyTable.reloadData()
            }
        }).disposed(by: disposeBag)
        
        filteredCurrenciesRates = currenciesRates
        
        viewModel.getCurrenciesNames()
        viewModel.getAllRates(base: baseCurrency)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrenciesRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListViewCell
        cell.currencyName.text = curenciesNames[String(Array(filteredCurrenciesRates)[indexPath.row].key)]
        cell.currencyValue.text = String(Array(filteredCurrenciesRates)[indexPath.row].value)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CurrencyInfoController") as? InfoVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 1) {
            self.searchBar.alpha = 0
        }
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBaseRate))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchRates))
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItems = [search, edit]
        })

        self.searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredCurrenciesRates = searchText.isEmpty ? self.currenciesRates : self.currenciesRates.filter({$0.key.prefix(searchText.count) == searchText})
        
        currencyTable.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView)-> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
        return Array(curenciesNames.values).count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String? {
        
        self.pickerBaseCurrency = Array(self.curenciesNames.keys)[row]
        print(Array(curenciesNames.values)[row])
        return Array(curenciesNames.values)[row]
    }
    
    
    
    @objc func editBaseRate(){
        
        if (editActive) {
            UIView.animate(withDuration: 1) {
                self.popUpView.alpha = 0
                self.popUpView.center.y = 0
            }
//            popUpView.removeFromSuperview()
        }
        else{
            UIView.animate(withDuration: 1) {
                self.popUpView.alpha = 1
                self.popUpView.center.y = self.view.center.y
            }
        }
        self.editActive = !self.editActive

    }
    
    @objc func searchRates(){
        navigationItem.rightBarButtonItems?.removeAll()
        UIView.animate(withDuration: 1) {
            self.searchBar.alpha = 1
            self.navigationItem.titleView = self.searchBar
        }
    }
    
    @objc func confirmChanges(){
        self.baseCurrency = self.pickerBaseCurrency
        viewModel.getAllRates(base: self.baseCurrency)
        UIView.animate(withDuration: 1) {
            self.popUpView.alpha = 0
            self.popUpView.center.y = 0
            self.editActive = false
        }
    }
    @objc func closePopUp(){
        UIView.animate(withDuration: 1) {
            self.popUpView.alpha = 0
            self.popUpView.center.y = 0
            self.editActive = false
        }
    }
}
