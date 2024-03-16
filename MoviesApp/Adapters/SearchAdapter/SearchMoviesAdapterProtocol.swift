//
//  SearchMoviesAdapterProtocol.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

protocol SearchMoviesAdapterProtocol {
    var datasource: [Movies] { get set }
    
    func setSearchBar(_ searchBar: UISearchBar)
    func didFilterHandler(_ handler: @escaping (_ result: [Any]) -> Void )
    
}
