//
//  searchMovieByInformationAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

class searchMovieByInformationAdapter: NSObject, SearchMoviesAdapterProtocol {
    var datasource: [Movies] = []
    private var didFilter: ((_ result: [Any]) -> Void)?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
        
    }
    
    func didFilterHandler(_ handler: @escaping ([Any]) -> Void) {
        self.didFilter = handler
    }
}

extension searchMovieByInformationAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var arrayResult: [Movies] = []
        let searchTextLowercased = searchText.lowercased()
        
        if searchTextLowercased.isEmpty {
            arrayResult = self.datasource
        } else {
            arrayResult = self.datasource.filter({ movies in
                let movieName = movies.title.lowercased()
                let searchName = searchText.lowercased()
                return movieName.contains(searchName)
            })
           /*
            arrayResult = self.datasource.filter({ movies in
                movies.title.lowercased().contains(searchText.lowercased())
            })
            */
        }
        
        self.didFilter?(arrayResult)
    }
}
