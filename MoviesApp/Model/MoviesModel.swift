//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//

import Foundation


struct Movies {
    let id: Int
    let original_language: String
    private let original_title: String?
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
    
    var titleNil: String {
        guard let titleUpdate = self.original_title else {
            return title
        }
        return "\(titleUpdate)"
    }
    
    init(
        dto: MoviesWebService.MovieDTO) {
            self.id = dto.id ?? 0
            self.original_language = dto.original_language ?? "Not Available"
            self.original_title = dto.original_title
            self.overview = dto.overview ?? "Not Available"
            self.popularity = Float(dto.popularity ?? 0.0)
            self.posterPath = dto.poster_path ?? "Not Available"
            self.releaseDate = dto.release_date ?? "Not Available"
            self.title = dto.title ?? "Not Available"
            self.video = dto.video ?? false
            self.vote_average = Float(dto.vote_average ?? 0)
            self.vote_count = dto.vote_count ?? 0
        }
}

extension Array where Element == MoviesWebService.MovieDTO {
    var toMovies: [Movies] {
        self.map({Movies(dto: $0)})
    }

}


