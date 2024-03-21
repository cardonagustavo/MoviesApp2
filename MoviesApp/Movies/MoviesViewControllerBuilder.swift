//
//  MoviesViewControllerBuilder.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import Foundation


extension MoviesViewController {
    class func buildFavorites() -> MoviesViewController {
        let moviesView = MoviesView(listAdapter: FavoritesListAdapter(), searchAdapter: searchMovieByMovieName())
        let controller = MoviesViewController(moviesView: moviesView, strategy: LocalMoviesStategyCD(moviesView: moviesView))
        return controller
    }
    
    class func buildMovies() -> MoviesViewController {
        let moviesView = MoviesView(listAdapter: MoviesListAdapter(), searchAdapter: SearchMovieByYearAdapter())
        let controller = MoviesViewController(moviesView: moviesView, strategy: ApiMoviesStrategy(moviesView: moviesView))
        return controller
    }
    
}
