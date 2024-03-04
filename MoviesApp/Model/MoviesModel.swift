//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//

import Foundation


struct Movies {
    let id: Int
    let originalLanguage: String
    private let originalTitle: String?
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    var titleNil: String {
        guard let titleUpdate = self.originalTitle else {
            return title
        }
        return "\(titleUpdate)"
    }
    
    init(
        dto: MoviesWebService.MovieDTO) {
            self.id = dto.id ?? 0
            self.originalLanguage = dto.originalLanguage ?? "Not Available"
            self.originalTitle = dto.originalTitle
            self.overview = dto.overview ?? "Not Available"
            self.popularity = dto.popularity ?? 0.0
            self.posterPath = dto.poster_path ?? "Not Available"
            self.releaseDate = dto.release_date ?? "Not Available"
            self.title = dto.title ?? "Not Available"
            self.video = dto.video ?? false
            self.voteAverage = dto.voteAverage ?? 0
            self.voteCount = dto.voteCount ?? 0
        }
}

extension Array where Element == MoviesWebService.MovieDTO {
    var toMovies: [Movies] {
        self.map({Movies(dto: $0)})
    }

}


