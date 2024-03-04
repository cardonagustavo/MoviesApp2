//
//  DetailsModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/03/24.
//

import Foundation

struct MovieDetails {
    let originalTitle: String?
    let overview: String
    let backdrop: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    
    var titleNil: String {
        guard let titleUpdate = self.originalTitle else {
            return title
        }
        return "\(titleUpdate)"
    }
    
    init(
        dto: MoviesWebService.MovieDetailDTO) {
            self.originalTitle = dto.originalTitle
            self.overview = dto.overview ?? "Not Available"
            self.posterPath = dto.posterPath ?? "Not Available"
            self.releaseDate = dto.releaseDate ?? "Not Available"
            self.title = dto.originalTitle ?? "Not Available"
            self.backdrop = dto.backdropPath ?? ""
            self.voteAverage = dto.voteAverage ?? 0
        }
}

struct Genre {
    var id: Int?
    var name: String?
    
    mutating func int(
        dto: MoviesWebService.Genre) {
            self.id = dto.id ?? 0
            self.name = dto.name ?? ""
        }
}
