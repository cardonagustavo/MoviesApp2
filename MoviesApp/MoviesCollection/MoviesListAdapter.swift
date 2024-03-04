//
//  MoviesListAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/02/24.
//

import UIKit

//MARK: - Protocol
protocol MoviesListAdapterProtocol {
    var datasource: [Movies] { get set }
    
    func setCollectionView(_ collectionView: UICollectionView)
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void )
    
}

//MARK: - class
class MoviesListAdapter: NSObject, MoviesListAdapterProtocol {
    
    private unowned var collectionView: UICollectionView?
    private var didSelect: ((_ movies: Movies) -> Void)?
    
    var datasource = [Movies]()
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.setMoviesLayout()
    }
    
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void ) {
        self.didSelect = handler
    }
    
    func setMoviesLayout() {
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 20
        
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
        MoviesCollectionViewCell.buildIn(collectionView, in: indexPath, whit: self.datasource[indexPath.item])
        
    }
}

//MARK: - Extension - UICollectionViewDelegate
extension MoviesListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelect?(self.datasource[indexPath.row])
        
    }
}
