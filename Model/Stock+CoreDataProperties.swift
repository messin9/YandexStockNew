//
//  Stock+CoreDataProperties.swift
//  yandexStock
//
//  Created by Алексей on 21.03.2021.
//
//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?

}

extension Stock : Identifiable {

}
