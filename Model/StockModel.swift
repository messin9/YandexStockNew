//
//  stockModel.swift
//  yandexStock
//
//  Created by Алексей on 19.02.2021.
//

import UIKit

struct StockModel: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double?
    let change : Double?
    let imageUrl: String?
    
//    init(symbol: String, companyName: String, latestPrice: Double, change: Double, imageUrl: String, isFavorite: Bool = false) {
//        self.isFavorite = false
//        self.symbol =
//        self.companyName = companyName
//        self.imageUrl = imageUrl
//        self.latestPrice = latestPrice
//        self.change = change
//    }
}

struct StockAppear {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let change : Double
    let imageUrl: String
    var isFavorite: Bool = false
    
    init(with stockModel: StockModel) {
        self.change = stockModel.change ?? 0
        self.companyName = stockModel.companyName
        self.imageUrl = stockModel.imageUrl ?? ""
        self.isFavorite = false
        self.latestPrice = stockModel.latestPrice ?? 0
        self.symbol = stockModel.symbol
        
    }
}





