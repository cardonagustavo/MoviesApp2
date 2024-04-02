//
//  SearchMovieByYearAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

// MARK: - Search Movie By Year Adapter

/// Clase para gestionar la búsqueda de películas por año.
class SearchMovieByYearAdapter: NSObject, SearchMoviesAdapterProtocol {
    
    // MARK: - Propiedades
    
    /// Arreglo que contiene las películas a buscar.
    var datasource: [Movies] = []
    private var didFilter: FilterCompletionHandler?
    
    // MARK: - Métodos
    
    /// Establece la barra de búsqueda para la adaptador.
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    /// Establece el controlador de filtrado de resultados.
    func didFilterHandler(_ handler: @escaping FilterCompletionHandler) {
        self.didFilter = handler
    }

}

// MARK: - UISearchBarDelegate

extension SearchMovieByYearAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var arrayResult: [Any] = []
        let searchTextLowercased = searchText.lowercased()
        
        if searchTextLowercased.isEmpty {
            arrayResult = self.datasource
        } else {
            arrayResult = self.datasource.filter({ movies in
                movies.title.lowercased().contains(searchTextLowercased) || movies.release_date.contains(searchTextLowercased)
            })
            
            if arrayResult.isEmpty {
                let noResultsMessage = StringsLocalizable.ErrorView.noResultsMessage.localized() + "\n\(searchText)"
                arrayResult = [noResultsMessage]
            }
        }
        
        let noFavoritesMessage = StringsLocalizable.ErrorView.noFavoritesMessage.localized()
        self.didFilter?(arrayResult, noFavoritesMessage)
    }
}

// MARK: - Typealias

extension SearchMovieByYearAdapter {
    typealias FilterCompletionHandler = ([Any], String) -> Void
}
