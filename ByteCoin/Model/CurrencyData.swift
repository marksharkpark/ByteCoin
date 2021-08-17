//
//  CurrencyData.swift
//  ByteCoin
//
//  Created by Mark Park on 8/16/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
// CurrencyData is the data received immediately after parsing the JSON from coinbase RESTful API.
struct CurrencyData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double 
}
