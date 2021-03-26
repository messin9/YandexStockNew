//
//  NetworkService.swift
//  yandexStock
//
//  Created by Алексей on 24.02.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let jsonUrlString = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=pk_8d561d50f34c4fb78ebba6d7cbbb4235&listLimit=100"
    
    private init() {}
    
    func fetchData(completion: @escaping ([StockModel]?) -> Void) {
        var stocks: [StockModel] = []
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do{
                stocks = try JSONDecoder().decode([StockModel].self, from: data)
                DispatchQueue.main.async {
                    completion(stocks)
                }
            } catch let error {
                print("error serialization JSON", error)
                completion(nil)
            }
            
        }.resume()
    }
}



