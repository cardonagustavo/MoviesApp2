//
//  MoviesEntity+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.
//
//

import Foundation
import CoreData

/// Extension for `MoviesEntity` providing additional functionality.
extension MoviesEntity {
    
    /// Fetch request for retrieving `MoviesEntity` instances.
    ///
    /// - Returns: An `NSFetchRequest` instance configured to retrieve `MoviesEntity` instances.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesEntity> {
        return NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
    }
    
    // MARK: - Attributes
    
    /// Unique identifier of the movie entity.
    @NSManaged public var id: Int64
    
    /// Name of the movie.
    @NSManaged public var name_movie: String?
    
    /// File path of the movie poster.
    @NSManaged public var posterPath_movie: String?
    
    /// Release date of the movie.
    @NSManaged public var releaseDate_movie: String?
}

/// Extension for `MoviesEntity` conforming to `Identifiable`.
extension MoviesEntity: Identifiable {
    
}

