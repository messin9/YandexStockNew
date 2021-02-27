//
//  stockCell.swift
//  yandexStock
//
//  Created by Алексей on 19.02.2021.
//

import UIKit

class StockCell: UICollectionViewCell {
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockTicker: UILabel!
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var stockValue: UILabel!
    @IBOutlet weak var stockFavouriteButton: UIButton!
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        
        if sender.image(for: .normal) == UIImage.init(systemName: "star") {
            sender.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        }
        else {
            sender.setImage(UIImage.init(systemName: "star"), for: .normal)
        }
    }
    
    func ConfigureCell (cell: UICollectionViewCell, for indexPath: IndexPath) {
        
        let stock = stocks[indexPath.item]
        stockTicker.text = stock.symbol
        stockName.text = stock.companyName
        stockPrice.text = String(stock.latestPrice)
        stockValue.text = String(stock.change)

    }
}




