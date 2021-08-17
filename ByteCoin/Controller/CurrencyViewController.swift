//
//  CurrencyViewController.swift
//  ByteCoin
//
//  Created by Mark Park on 8/11/21.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    // Purpose: Determines the number of columns we want in our picker.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Purpose: Returning the number of rows we want in our picker.
    // Just return the size of the array that holds our different currencies.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // Purpose: Returning the value for the corresponding row inside of our picker.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let coin = coinManager.currencyArray[row]
        print(coinManager.getCoinPrice(for: coin))
    }
}
//MARK: CoinManagerDelegate
    extension CurrencyViewController: CoinManagerDelegate{
        func getCurrencyRep(coinManager: CoinManager, data: CurrencyModel){
            DispatchQueue.main.async {
                self.bitcoinLabel.text = data.rateString
                self.currencyLabel.text = data.asset_id_quote
            }
        }
        func didFailWithError(error: Error) {
            print(error)
        }
    }


 
