//
//  DetailsModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/03/24.
//

import Foundation

/// Representa un modelo de datos para una película.
struct MovieDetail {
    
    /// Indica si la película es para adultos.
    let adult: Bool
    
    /// Ruta de la imagen de fondo de la película.
    let backdrop_path: String
    
    /// Identificadores de género asociados con la película.
    let genre_ids: [Int]
    
    /// Géneros asociados con la película.
    let genres: [MoviesWebService.GenreDTO]
    
    /// Identificador único de la película.
    let id: Int
    
    /// Idioma original de la película.
    let original_language: String
    
    /// Título original de la película.
    let original_title: String
    
    /// Descripción general de la película.
    let overview: String
    
    /// Popularidad de la película.
    let popularity: Double
    
    /// Ruta del póster de la película.
    let poster_path: String
    
    /// Fecha de lanzamiento de la película.
    let release_date: String
    
    /// Título de la película.
    let title: String
    
    /// Indica si la película tiene video.
    let video: Bool
    
    /// Calificación promedio de la película.
    let vote_average: Float
    
    /// Número de votos recibidos por la película.
    let vote_count: Int
    
    var formattedReleaseDateForMovies: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let inputDate = inputDateFormatter.date(from: self.release_date) else {
            return ""
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        
        let formattedDate = outputDateFormatter.string(from: inputDate)
        
        let localizedTitle = NSLocalizedString(LocalizedStrings.releaseDateTitle, comment: "Release Date")
        return "\(localizedTitle):\n\(formattedDate)"
    }

    var formattedReleaseDateForFavorite: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let inputDate = inputDateFormatter.date(from: self.release_date) else {
            return ""
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMMM yyyy"
        
        let formattedDate = outputDateFormatter.string(from: inputDate)
        
        let localizedTitle = NSLocalizedString(LocalizedStrings.releaseDateTitle, comment: "Release Date")
        return "\(localizedTitle):\n\(formattedDate)"
    }
    /// Inicializa una instancia de Movie a partir de un objeto MovieDTO.
    ///
    /// - Parameter dto: Objeto de transferencia de datos de película (MovieDTO).
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
    
    /// Inicializa una instancia de Movie a partir de un objeto MovieDetailDTO.
    ///
    /// - Parameter detailDto: Objeto de transferencia de datos de detalles de película (MovieDetailDTO).
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
    
    /// Inicializa una instancia de Movie a partir de un objeto Favorite.
    ///
    /// - Parameter favorite: Objeto de película favorita (Favorite).
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



/// Representa una película favorita.
struct Favorite: Codable {
    /// Identificador único de la película.
    let id: Int
    
    /// Ruta del póster de la película.
    let poster_path: String
    
    /// Título de la película.
    let title: String
    
    /// Fecha de lanzamiento de la película.
    let release_date: String
}

/// Extensión que proporciona una conversión de una matriz de objetos MovieDTO a una matriz de objetos Movie.
extension Array where Element == MoviesWebService.MovieDTO {
    
    /// Convierte una matriz de objetos MovieDTO a una matriz de objetos Movie.
    var toList: [MovieDetail] {
        self.map({ MovieDetail(dto: $0) })
    }
}

/// Extensión que proporciona una conversión de una matriz de objetos MovieDetailDTO a una matriz de objetos Movie.
extension Array where Element == MoviesWebService.MovieDetailDTO {
    
    /// Convierte una matriz de objetos MovieDetailDTO a una matriz de objetos Movie.
    var toList: [MovieDetail] {
        self.map({ MovieDetail(detailDto: $0) })
    }
}

/// Extensión que proporciona una conversión de una matriz de objetos Favorite a una matriz de objetos Movie.
extension Array where Element == Favorite {
    
    /// Convierte una matriz de objetos Favorite a una matriz de objetos Movie.
    var toMovies: [MovieDetail] {
        self.map({ MovieDetail(favorite: $0) })
    }
}

