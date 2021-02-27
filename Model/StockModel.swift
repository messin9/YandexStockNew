//
//  stockModel.swift
//  yandexStock
//
//  Created by Алексей on 19.02.2021.
//

import Foundation
import UIKit

struct StockModel: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let change : Double
//    let urlImage: String?
//    let isFavourite : Bool
    
    
}
