//
//  MoviesEntity+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.
//
//

import Foundation
import CoreData


extension MoviesEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesEntity> {
        return NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name_movie: String?
    @NSManaged public var posterPath_movie: String?
    @NSManaged public var releaseDate_movie: String?
    
}

extension MoviesEntity : Identifiable {
    
}
