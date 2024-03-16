//
//  MoviesListAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/02/24.
//

import UIKit

//MARK: - class
class MoviesListAdapter: NSObject, MoviesListAdapterProtocol {
    
    private unowned var collectionView: UICollectionView?
    private var didSelect: ((_ movies: Movies) -> Void)?
    
    var datasource = [Any]() {
        didSet {
            self.datasource is [Movies] ? self.setMoviesLayout() : self.setErrorLayout()
        }
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.dataSource = self
        self.setMoviesLayout()
        self.collectionView?.register(UINib(nibName: "ErrorCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ErrorCollectionViewCell")
        self.collectionView?.register(UINib(nibName: "MoviesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void ) {
        self.didSelect = handler
    }
    
    func setMoviesLayout() {
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 1)
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
extension MoviesListAdapter: UICollectionViewDataSource {
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       self.datasource.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = self.datasource[indexPath.row]
        
        if let message = item as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, in: indexPath, whit: message)
        } else {
          if  let movie = item as? Movies {
                return MoviesCollectionViewCell.buildIn(collectionView, in: indexPath, whit: movie)
            } else {
                return UICollectionViewCell()
            }
        }
        
    }
}
