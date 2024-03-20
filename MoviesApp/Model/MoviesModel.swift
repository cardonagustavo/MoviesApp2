//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//

import Foundation

/// Representa un modelo de datos para películas.
struct Movies {
    
    /// Identificador único de la película.
    let id: Int
    
    /// Idioma original de la película.
    let original_language: String
    
    /// Título original de la película.
    private let original_title: String?
    
    /// Descripción general de la película.
    let overview: String
    
    /// Popularidad de la película.
    let popularity: Float
    
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
    
    /// Título de la película o un valor predeterminado si el título original no está disponible.
    var titleNil: String {
        guard let titleUpdate = self.original_title else {
            return title
        }
        return "\(titleUpdate)"
    }
    
    var formattedReleaseDateForMovies: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let inputDate = inputDateFormatter.date(from: self.release_date) else {
            return ""
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        
        let formattedDate = outputDateFormatter.string(from: inputDate)
        
        return """
        Fecha de lanzamiento:
        \(formattedDate)
        """
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
        
        return formattedDate
    }

    
    /// Inicializa una instancia de Movies a partir de un objeto MovieDTO.
    ///
    /// - Parameter dto: Objeto de transferencia de datos de película (MovieDTO).
    init(dto: MoviesWebService.MovieDTO) {
        self.id = dto.id ?? 0
        self.original_language = dto.original_language ?? "Not Available"
        self.original_title = dto.original_title
        self.overview = dto.overview ?? "Not Available"
        self.popularity = Float(dto.popularity ?? 0.0)
        self.poster_path = dto.poster_path ?? "Not Available"
        self.release_date = dto.release_date ?? "Not Available"
        self.title = dto.title ?? "Not Available"
        self.video = dto.video ?? false
        self.vote_average = Float(dto.vote_average ?? 0)
        self.vote_count = dto.vote_count ?? 0
    }
}

/// Extensión que proporciona una conversión de una matriz de objetos MovieDTO a una matriz de objetos Movies.
extension Array where Element == MoviesWebService.MovieDTO {
    
    /// Convierte una matriz de objetos MovieDTO a una matriz de objetos Movies.
    var toMovies: [Movies] {
        self.map({ Movies(dto: $0) })
    }
}
