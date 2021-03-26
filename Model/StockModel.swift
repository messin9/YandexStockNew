//
//  stockModel.swift
//  yandexStock
//
//  Created by Алексей on 19.02.2021.
//

import UIKit
import CoreData

struct StockModel: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double?
    let change : Double?
    let imageUrl: String?
    var isFavorite: Bool? = false
}

