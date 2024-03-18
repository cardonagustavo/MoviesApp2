//
//  SearchMovieByYearAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

class SearchMovieByYearAdapter: NSObject, SearchMoviesAdapterProtocol {
    var datasource: [Movies] = []
    private var didFilter: ((_ result: [Any]) -> Void)?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    func didFilterHandler(_ handler: @escaping ([Any]) -> Void) {
        self.didFilter = handler
    }
}

extension SearchMovieByYearAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var arrayResult: [Any] = []
        let searchTextLowercased = searchText.lowercased()
        
        if searchTextLowercased.isEmpty {
            arrayResult = self.datasource
        } else {  /*
            arrayResult = self.datasource.filter({ movies in
                let movieName = movies.title.lowercased()
                let searchName = searchText.lowercased()
                return movieName.contains(searchName)
            })*/
          
            arrayResult = self.datasource.filter({ movies in
                movies.title.lowercased().contains(searchText.lowercased()) || movies.release_date.contains(searchTextLowercased)
            })
            
            arrayResult = !arrayResult.isEmpty ? arrayResult : ["""
            No se encontraron resultados para la busqueda de:
            \(searchText)
            """]
        }
        self.didFilter?(arrayResult)
    }
}
