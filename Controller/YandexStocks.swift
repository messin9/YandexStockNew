//
//  ViewController.swift
//  yandexStock
//
//  Created by Алексей on 18.02.2021.
//

import UIKit

class YandexStocks: UIViewController {
    
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var stockSearch: UISearchBar!
    @IBOutlet weak var stockSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    @IBAction func stockSegmentedChanged(_ sender: UISegmentedControl) {
    }
    
}

extension YandexStocks: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
}

extension YandexStocks: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stockCell", for: indexPath) as! StockCell
        
        cell.ConfigureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stocks.count
    }
    
}

