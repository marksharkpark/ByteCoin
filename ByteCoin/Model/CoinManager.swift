//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Mark Park on 8/16/21.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didFailWithError(error: Error)
    func getCurrencyRep(coinManager: CoinManager, data: CurrencyModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FE795798-0667-44EA-B5A0-9A7953861B19"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/USD?apikey=\(apiKey)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error:error!)
                }
                if let safeData = data {
                    if let currency = self.parseJSON(safeData){
                        // Need to create delegate method to pass this data to our viewController.
                        self.delegate?.getCurrencyRep(coinManager: self, data: currency)
                        print(currency.rate) // price
                        print(currency.asset_id_quote) // cash currency
                        print(currency.asset_id_base) // coin currency
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let rate = decodedData.rate
            let coin = decodedData.asset_id_base 
            let price = decodedData.asset_id_quote
            let currency = CurrencyModel(rate: rate, asset_id_base: coin, asset_id_quote: price)
            return currency
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
