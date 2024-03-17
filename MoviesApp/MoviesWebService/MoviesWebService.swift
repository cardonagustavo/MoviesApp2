//  MoviesWebServise.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import Foundation
import Alamofire

// MARK: - Web Service

/// Clase para interactuar con un servicio web de películas.
class MoviesWebService {
    
    /// URL base para el servicio de películas populares.
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    
    /// Método para obtener una lista de películas populares.
    ///
    /// - Parameter completionHandler: El bloque de finalización que se llama cuando se ha completado la solicitud de películas. Recibe un array de películas (`MoviesDTO`).
    func fetch(completionHandler: @escaping CompletionHandler) {
        
        // Realiza una solicitud GET a la URL especificada para obtener datos sobre películas populares.
        AF.request(urlString, method: .get).response {  dataResponse in
            // Verifica si hay datos válidos en la respuesta.
            guard let data = dataResponse.data else { return }
            
            // Intenta decodificar los datos recibidos en un objeto `MoviesDTO`.
            let arrayResponse = try? JSONDecoder().decode(MoviesDTO.self, from: data)
            
            // Llama al completionHandler pasándole el objeto `MoviesDTO` decodificado o un objeto `MoviesDTO` vacío si la decodificación falla.
            completionHandler(arrayResponse ?? MoviesDTO())
        }
    }
    
    /// Método para obtener detalles de una película específica.
    ///
    /// - Parameters:
    ///   - idMovie: El ID de la película.
    ///   - completionHandler: El bloque de finalización que se llama cuando se ha completado la solicitud de detalles de la película. Recibe un objeto `MovieDetailDTO` que representa los detalles de la película.
    func retriveMovies(idMovie: Int, completionHandler: @escaping CompleticionDetailsHandler) {
        // URL para obtener detalles de la película específica.
        let moviesDetails = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
        
        // Realiza una solicitud GET a la URL especificada para obtener detalles de la película.
        AF.request(moviesDetails, method: .get).response { dataResponse in
            // Verifica si hay datos válidos en la respuesta.
            guard let data = dataResponse.data else { return }
            
            // Intenta decodificar los datos recibidos en un objeto `MovieDetailDTO`.
            let response = try? JSONDecoder().decode(MovieDetailDTO.self, from: data)
            
            // Llama al completionHandler pasándole el objeto `MovieDetailDTO` decodificado o un objeto `MovieDetailDTO` vacío si la decodificación falla.
            completionHandler(response ?? MovieDetailDTO())
        }
    }
}


// MARK: - Clousures

extension MoviesWebService {
    /// Definición de un bloque de finalización para la solicitud de películas.
    typealias CompletionHandler = (_ arrayMoviesDTO: MoviesDTO) -> Void
    
    /// Definición de un bloque de finalización para la solicitud de detalles de película.
    typealias CompleticionDetailsHandler = (_ arrayMovies: MovieDetailDTO) -> Void
}

// MARK: - DTO

extension MoviesWebService {
    /// Estructura para representar la respuesta de películas.
    struct MoviesDTO: Decodable {
        let page: Int?
        let results: [MovieDTO]?
        let total_pages: Int?
        let total_results: Int?
        
        init() {
            self.page = 0
            self.results = []
            self.total_pages = 0
            self.total_results = 0
        }
    }
    
    /// Estructura para representar una película.
    struct MovieDTO: Decodable {
        let adult: Bool?
        let backdrop_path: String?
        let genre_ids: [Int]?
        let id: Int?
        let original_language: String?
        let original_title: String?
        let overview: String?
        let popularity: Double?
        let poster_path: String?
        let release_date: String?
        let title: String?
        let video: Bool?
        let vote_average: Float?
        let vote_count: Int?
        
        init() {
            self.adult = false
            self.backdrop_path = ""
            self.genre_ids = []
            self.id = 0
            self.original_language = ""
            self.original_title = ""
            self.overview = ""
            self.popularity = 0.0
            self.poster_path = ""
            self.release_date = ""
            self.title = ""
            self.video = false
            self.vote_average = 0.0
            self.vote_count = 0
        }
    }
    
    /// Estructura para representar los detalles de una película.
    struct MovieDetailDTO: Decodable {
        let adult: Bool?
        let backdrop_path: String?
        let budget: Int?
        let genres: [GenreDTO]?
        let homepage: String?
        let id: Int?
        let imdb_id, original_language, original_title, overview: String?
        let popularity: Double?
        let poster_path: String?
        let production_companies: [ProducerCompanyDTO]?
        let production_countries: [ProducerCountryDTO]?
        let release_date: String?
        let revenue, runtime: Int?
        let spoken_languages: [LanguageDTO]?
        let status, tagline, title: String?
        let video: Bool?
        let vote_average: Float?
        let vote_count: Int?
        
        init() {
            self.adult = false
            self.backdrop_path = ""
            self.budget = 0
            self.genres = []
            self.homepage = ""
            self.id = 0
            self.imdb_id = ""
            self.original_language = ""
            self.original_title = ""
            self.overview = ""
            self.popularity = 0.0
            self.poster_path = ""
            self.production_companies = []
            self.production_countries = []
            self.release_date = ""
            self.revenue = 0
            self.runtime = 0
            self.spoken_languages = []
            self.status = ""
            self.tagline = ""
            self.title = ""
            self.video = false
            self.vote_average = 0.0
            self.vote_count = 0
        }
    }
    
    // MARK: - Genre
    
    /// Estructura que representa un género de película.
    struct GenreDTO: Decodable {
        /// El ID único del género.
        let id: Int?
        
        /// El nombre del género.
        let name: String?
    }
    
    // MARK: - ProducerCompany
    
    /// Estructura que representa una compañía productora de películas.
    struct ProducerCompanyDTO: Decodable {
        /// El ID único de la compañía.
        let id: Int?
        
        /// La ruta del logotipo de la compañía.
        let logo_path: String?
        
        /// El nombre de la compañía.
        let name: String?
        
        /// El país de origen de la compañía.
        let origin_country: String?
    }
    
    // MARK: - ProducerCountry
    
    /// Estructura que representa un país productor de películas.
    struct ProducerCountryDTO: Codable {
        /// El nombre del país.
        let name: String?
    }
    
    // MARK: - Language
    
    /// Estructura que representa un idioma utilizado en una película.
    struct LanguageDTO: Codable {
        /// El nombre en inglés del idioma.
        let english_name: String?
        
        /// El nombre del idioma.
        let name: String?
    }
}
