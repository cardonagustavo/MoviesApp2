//
//  MoviesListSimpleAdapterProtocol.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit


//MARK: - Protocol
protocol MoviesListAdapterProtocol {
    var datasource: [Any] { get set }
    
    func setCollectionView(_ collectionView: UICollectionView)
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void )
    
}
