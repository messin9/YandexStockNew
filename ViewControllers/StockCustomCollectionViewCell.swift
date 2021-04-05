//
//  stockCell.swift
//  yandexStock
//
//  Created by Алексей on 19.02.2021.
//
import UIKit

class StockCustomCollectionViewCell: UICollectionViewCell {
    
    var delegate: YandexStocksViewController!
    
//MARK: IBOutlets/IBActions
    @IBOutlet weak var stockImageLabel: UIImageView!
    @IBOutlet weak var stockTickerLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockValueLabel: UILabel!
    @IBOutlet weak var stockFavouriteButtonLabel: UIButton!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        delegate.favButtonAction(button: stockFavouriteButtonLabel, cell: self)
    }
    
//MARK: CellConfiguration
    func configureLAbels (with stock: StockAppear) {
        stockTickerLabel.text = stock.symbol
        stockNameLabel.text = stock.companyName
        stockPriceLabel.text = "$" + String(stock.latestPrice )
        stockValueLabel.text = String(stock.change ) + "%"      
        if stock.change == 0 {stockValueLabel.textColor = .black}
        else if stock.change > 0 {stockValueLabel.textColor = .green}
        else {stockValueLabel.textColor = .red}
    }
    
    func cacheImage (with stock: StockAppear, placeholder: UIImage? = nil, cache: URLCache = URLCache.shared ) {
        let imageUrl = "https://storage.googleapis.com/iex/api/logos/\(stock.symbol).png"
        guard let url = URL(string: imageUrl) else { return }
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.stockImageLabel.image = image
            return
        }
        let placeholder = UIImage(systemName: "exclamationmark.icloud.fill")
        self.stockImageLabel.image = placeholder
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response,
                ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                let image = UIImage(data: data)
            else { return }
            let cachedData = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            DispatchQueue.main.async {
                self.stockImageLabel.image = image
            }
        }.resume()
    }
    
}

