//
//  FavoritesListAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit


//MARK: - class
class FavoritesListAdapter: NSObject, MoviesListAdapterProtocol {
    
    private unowned var collectionView: UICollectionView?
    private var didSelect: ((_ movies: Movies) -> Void)?
    
    var datasource = [Any]() {
        didSet {
            self.datasource is [Movies] ? self.setFavoritesLayout() : self.setErrorLayout()
        }
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.setFavoritesLayout()
        self.collectionView?.register(UINib(nibName: "ErrorCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ErrorCollectionViewCell")
        self.collectionView?.register(UINib(nibName: "FavoritesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
    }
    
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void ) {
        self.didSelect = handler
    }
    
    func setFavoritesLayout() {
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
        
    }
    
    func setErrorLayout() {
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 1)
        group.interItemSpacing = .fixed(0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
        
    }
}

//MARK: - Extension - UICollectionViewDataSource
extension FavoritesListAdapter: UICollectionViewDataSource {
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       self.datasource.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = self.datasource[indexPath.row]
        
        if let message = item as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, in: indexPath, whit: message)
        } else {
          if  let movie = item as? Movies {
                return FavoritesCollectionViewCell.buildIn(collectionView, in: indexPath, whit: movie)
            } else {
                return UICollectionViewCell()
            }
        }
        
        
    }
}

//MARK: - Extension - UICollectionViewDelegate
extension FavoritesListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = self.datasource[indexPath.row] as? Movies else { return }
        self.didSelect?(movies)
        
    }
}

extension FavoritesListAdapter {
    typealias CompletionDidSelectHandler = (_ movies: Movies) -> Void
}
