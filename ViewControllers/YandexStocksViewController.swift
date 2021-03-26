//
//  ViewController.swift
//  yandexStock
//
//  Created by Алексей on 18.02.2021.
//

import UIKit

class YandexStocksViewController: UIViewController {
//    UISearchControllerDelegate
//MARK: IBOutlets/Actions
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stockSegmented: UISegmentedControl!
    @IBOutlet var navigationItemOutlet: UINavigationItem!
    
    @IBAction func stockSegmentedChanged(_ sender: UISegmentedControl) {
    }
    
//MARK: Arrays
    private var stocks: [StockModel]!
    private var currentDataSource: [StockModel]!
    var favoritesStocks: [StockModel]!
    
//MARK: Configuring Search
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
        
    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    func filterCurrentDataSource(SearchTerm: String) {
        if SearchTerm.count > 0 {
            currentDataSource = stocks
            let filteredStocks = stocks.filter { $0.companyName.lowercased().contains(SearchTerm.lowercased())
                || $0.symbol.lowercased().contains(SearchTerm.lowercased())
            }
            currentDataSource = filteredStocks
            collectionView.reloadData()
        }
    }
    
    func restoreCurrentDataSource() {
        currentDataSource = stocks
        collectionView.reloadData()
    }
    
//MARK: CollectionViewLayout
    private let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchData { [weak self] stocks in
            guard let stocks = stocks else { return }
            self?.stocks = stocks
            self?.currentDataSource = stocks
            self?.collectionView.reloadData()
        }
        configureSearchController()
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension YandexStocksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20), height: 80)
    }
}

//MARK: UICollectionViewDataSource
extension YandexStocksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stockCell", for: indexPath) as! StockCustomCollectionViewCell

        cell.layer.cornerRadius = collectionView.frame.width / 20
        cell.stockImageLabel.layer.cornerRadius = cell.layer.cornerRadius / 2
        
        cell.configureLAbels(with: currentDataSource[indexPath.item])
        cell.cacheImage(with: currentDataSource[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentDataSource = self.currentDataSource else { return 0 }
    
        return currentDataSource.count
    }
}

//MARK: UISearchResultsUpdating
extension YandexStocksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterCurrentDataSource(SearchTerm: searchText)
        }
    }
    
}

//MARK: UISearchBarDelegate
extension YandexStocksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterCurrentDataSource(SearchTerm: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text, searchText.isEmpty {
            restoreCurrentDataSource()
        }

    }

}
