//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(currency: String, rate: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "ACB9E911-DAC8-4B50-8B5C-2FD98E21A493"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for selectedCurrency: String) {
        // 1. create URL
        let urlString = baseURL + selectedCurrency + "?apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        // 2. create session
        let session = URLSession(configuration: .default)
        // 3. assign data session to task
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            if let data = data {
                if let response = parseJSON(data) {
                    let priceString = String(format: "%.2f", response.rate)
                    self.delegate?.didUpdateCurrency(currency: selectedCurrency, rate: priceString)
                }
            }
            
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> Coin? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(Coin.self, from: data)
            return decoded
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
