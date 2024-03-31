//
//  SearchMovieByYearAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

class SearchMovieByYearAdapter: NSObject, SearchMoviesAdapterProtocol {
    var datasource: [Movies] = []
    private var didFilter: ((_ result: [Any],_ message: String ) -> Void)?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    func didFilterHandler(_ handler: @escaping ([Any], _ message: String) -> Void) {
        self.didFilter = handler
    }

}

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
