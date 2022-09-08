//
//  CurrencyListViewCell.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class CurrencyListViewCell: UITableViewCell {
    
    let viewModel = CurrencyListViewModel()
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.contentViewCell.addGestureRecognizer(gesture)
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        viewModel.getRatesList(base: "EUR")
    }
    
}
