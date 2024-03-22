//
//  ApiMoviesStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.
//

import Foundation

struct ApiMoviesStrategy: MoviesStrategy {
    private var moviesView = MoviesView()
    private lazy var webService = MoviesWebService()
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    mutating  func getWebServiceStrategy() {
        self.moviesView.showLoading(true)
        self.webService.fetch { [self] arrayMoviesDTO in
            guard let movies = arrayMoviesDTO.results?.toMovies else { return }
            self.moviesView.reloadData(movies)
            self.moviesView.showLoading(false)
        }
    }
}
