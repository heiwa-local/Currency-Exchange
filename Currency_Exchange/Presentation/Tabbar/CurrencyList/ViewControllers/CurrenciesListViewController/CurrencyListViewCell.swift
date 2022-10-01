//
//  CurrencyListViewCell.swift
//  Currency_Exchange
//
//  Created by kunari on 19.08.2022.
//

import Foundation
import UIKit

class CurrencyListViewCell: UITableViewCell {
        
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
