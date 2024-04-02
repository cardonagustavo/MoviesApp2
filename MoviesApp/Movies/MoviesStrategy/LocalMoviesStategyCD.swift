//  LocalMoviesStategyCD.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.

import Foundation
import CoreData
import UIKit

/// Struct that implements the MoviesStrategy protocol for fetching movies from local storage using Core Data.
struct LocalMoviesStategyCD: MoviesStrategy {
    
    private var moviesView: MoviesView
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// Initializes the LocalMoviesStategyCD with a MoviesView instance.
    /// - Parameter moviesView: The MoviesView instance to be associated with the strategy.
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    /// Fetches movies from local storage using Core Data.
    func getWebServiceStrategy() {
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            // Removes duplicate movies based on their id
            let uniqueMovieOnFavorites = favoriteMovies.removeDuplicates { $0.id }
            // Sorts the favorite movies in ascending order by name
            let sortedFavoriteMovies = uniqueMovieOnFavorites.sorted(by: { $0.name_movie ?? "" < $1.name_movie ?? "" })
            // Updates the moviesView with the sorted favorite movies
            self.moviesView.reloadData(sortedFavoriteMovies.toMoviesToFavoritesMovies, message: "String")
        } catch {
            print(StringsLocalizable.Messages.MovieRecoveryError + "\(error)")
        }
    }
}

/// Extension on Array for removing duplicate elements based on a key.
extension Array where Element: Equatable {
    
    /// Removes duplicate elements from the array based on a key generated by the provided closure.
    /// - Parameter key: The closure that generates a key for each element.
    /// - Returns: An array without duplicate elements.
    func removeDuplicates<T: Hashable>(byKey key: (Element) -> T) -> [Element] {
        var seen = [T: Bool]()
        return filter { seen.updateValue(true, forKey: key($0)) == nil }
    }
}
