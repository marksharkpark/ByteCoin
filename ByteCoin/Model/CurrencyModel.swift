//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by Mark Park on 8/16/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

// CurrencyModel is used in order to create an object from the Codable object, CurrencyData.

struct CurrencyModel{
    let rate: Double
    let asset_id_base: String // coin type
    let asset_id_quote: String // conversion type
    
    var rateString: String {
        return String(rate)
    }
}
