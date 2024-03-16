//
//  DetailsModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/03/24.
//

import Foundation

struct Movie {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let genres: [MoviesWebService.GenreDTO]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
    
    
    init(dto: MoviesWebService.MovieDTO) {
        self.adult = dto.adult ?? false
        self.backdrop_path = dto.backdrop_path ?? ""
        self.genre_ids = dto.genre_ids ?? []
        self.genres = []
        self.id = dto.id ?? 0
        self.original_language = dto.original_language ?? ""
        self.original_title = dto.original_title ?? ""
        self.overview = dto.overview ?? ""
        self.popularity = dto.popularity ?? 0.0
        self.poster_path = dto.poster_path ?? ""
        self.release_date = dto.release_date ?? ""
        self.title = dto.title ?? ""
        self.video = dto.video ?? false
        self.vote_average = dto.vote_average ?? 0.0
        self.vote_count = dto.vote_count ?? 0
    }
    
    init(detailDto: MoviesWebService.MovieDetailDTO) {
        self.adult = detailDto.adult ?? false
        self.backdrop_path = detailDto.backdrop_path ?? ""
        self.genre_ids = []
        self.genres = detailDto.genres ?? []
        self.id = detailDto.id ?? 0
        self.original_language = detailDto.original_language ?? ""
        self.original_title = detailDto.original_title ?? ""
        self.overview = detailDto.overview ?? ""
        self.popularity = detailDto.popularity ?? 0.0
        self.poster_path = detailDto.poster_path ?? ""
        self.release_date = detailDto.release_date ?? ""
        self.title = detailDto.title ?? ""
        self.video = detailDto.video ?? false
        self.vote_average = detailDto.vote_average ?? 0.0
        self.vote_count = detailDto.vote_count ?? 0
    }
    
    init(favorite: Favorite) {
        self.adult = false
        self.backdrop_path = ""
        self.genre_ids = []
        self.genres = []
        self.id = favorite.id
        self.original_language = ""
        self.original_title = ""
        self.overview = ""
        self.popularity = 0.0
        self.poster_path = favorite.poster_path
        self.release_date = favorite.release_date
        self.title = favorite.title
        self.video = false
        self.vote_average = 0.0
        self.vote_count = 0
    }
}

struct Favorite: Codable {
    let id: Int
    let poster_path: String
    let title: String
    let release_date: String
}

extension Array where Element == MoviesWebService.MovieDTO {
    var toList: [Movie] {
        self.map( { Movie(dto: $0) } )
    }
}

extension Array where Element == MoviesWebService.MovieDetailDTO {
    var toList: [Movie] {
        self.map( { Movie(detailDto: $0) } )
    }
}

extension Array where Element == Favorite {
    var toMovies: [Movie] {
        self.map( { Movie(favorite: $0) } )
    }
}

