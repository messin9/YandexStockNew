//
//  NetworkService.swift
//  yandexStock
//
//  Created by Алексей on 24.02.2021.
//

import Foundation
import UIKit

var stocks = [StockModel]()
    
    func fetchData() {
        
                
        let jsonUrlString = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=pk_8d561d50f34c4fb78ebba6d7cbbb4235&listLimit=100"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do{
                stocks = try JSONDecoder().decode([StockModel].self, from: data)
            } catch let error {
                print("error serialization JSON", error)
            }
            
        }.resume()
    }

