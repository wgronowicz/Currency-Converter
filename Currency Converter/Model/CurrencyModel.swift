//
//  CurrencyModel.swift
//  Currency Converter
//
//  Created by Wojciech Gronowicz on 21/10/2018.
//  Copyright © 2018 Wojciech Gronowicz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyModel {
    
    private let parameters : [String : String] = ["access_key" : "79b82a87cb786bf23a9579f6bdf06ed3"]
    private let fixer_url = "http://data.fixer.io/api/latest"
    private var currenciesRates : [String : Double] = ["AUD" : 1,"CAD" : 1,"EUR" : 1,"GBP" : 1,"JPY" : 1,"PLN" : 1,"USD" : 1]
    
    
    init() {
        getRate(url: fixer_url, parameters: parameters)
    }
    
    func getRate(url : String, parameters : [String : String]) {
        
        Alamofire.request(url, method : .get, parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let fixerData : JSON = JSON(response.result.value!)
                self.currenciesRates["AUD"] = fixerData["rates"]["AUD"].double!
                self.currenciesRates["CAD"] = fixerData["rates"]["CAD"].double!
                self.currenciesRates["EUR"] = fixerData["rates"]["EUR"].double!
                self.currenciesRates["GBP"] = fixerData["rates"]["GBP"].double!
                self.currenciesRates["JPY"] = fixerData["rates"]["JPY"].double!
                self.currenciesRates["PLN"] = fixerData["rates"]["PLN"].double!
                self.currenciesRates["USD"] = fixerData["rates"]["USD"].double!
                print(fixerData)
            }else {
                print("Error \(String(describing: response.result.error))")
            }
            
        }
    }
    
    func getMultiplyer(from : String, to : String) -> Double {
        
        return self.currenciesRates[to]! / self.currenciesRates[from]!
    }
    
}
