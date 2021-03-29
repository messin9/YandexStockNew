//
//  NetworkService.swift
//  yandexStock
//
//  Created by Алексей on 24.02.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let jsonUrlString = "https://cloud.iexapis.com/stable/stock/market/list/mostactive?token=pk_31814b353e184d8493520b87df2070c7"
    
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

