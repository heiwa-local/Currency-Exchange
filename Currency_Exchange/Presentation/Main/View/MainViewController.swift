//
//  ViewController.swift
//  Currency_Exchange
//
//  Created by kunari on 13.08.2022.
//

import UIKit
import RxSwift
import RxRelay

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Tabbar")
        self.navigationController?.pushViewController(vc, animated: false)
    }


}

