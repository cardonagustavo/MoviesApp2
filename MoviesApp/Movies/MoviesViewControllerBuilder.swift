//  MoviesViewControllerBuilder.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.

import Foundation

extension MoviesViewController {
    
    // MARK: - Factory Methods
    
    /// Builds a MoviesViewController instance for displaying favorite movies.
    ///
    /// - Returns: A MoviesViewController instance configured to display favorite movies.
    class func buildFavorites() -> MoviesViewController {
        let moviesView = MoviesView(listAdapter: FavoritesListAdapter(), searchAdapter: searchMovieByMovieName(), addPullToRefresh: false)
        let controller = MoviesViewController(moviesView: moviesView, strategy: LocalMoviesStategyCD(moviesView: moviesView))
        return controller
    }
    
    /// Builds a MoviesViewController instance for displaying all available movies.
    ///
    /// - Returns: A MoviesViewController instance configured to display all available movies.
    class func buildMovies() -> MoviesViewController {
        let moviesView = MoviesView(listAdapter: MoviesListAdapter(), searchAdapter: SearchMovieByYearAdapter(), addPullToRefresh: true)
        let controller = MoviesViewController(moviesView: moviesView, strategy: ApiMoviesStrategy(moviesView: moviesView))
        return controller
    }
}
