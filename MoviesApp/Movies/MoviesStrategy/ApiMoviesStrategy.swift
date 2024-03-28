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
//            print(arrayMoviesDTO)
            let movies = arrayMoviesDTO.results?.toMovies
//            print("here")
            self.moviesView.reloadData(movies ?? [], message: "servicio no disponible")
            self.moviesView.showLoading(false)
        }
    }
}
