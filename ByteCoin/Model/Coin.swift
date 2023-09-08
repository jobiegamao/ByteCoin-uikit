//
//  BTC.swift
//  ByteCoin
//
//  Created by may on 9/8/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Coin: Codable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
