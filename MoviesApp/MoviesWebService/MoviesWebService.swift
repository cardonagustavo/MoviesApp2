//  MoviesWebServise.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import Foundation
import Alamofire

// MARK: - Web Service

/// Clase para interactuar con un servicio web de películas.
struct MoviesWebService {
    /// Variable calculada que obtiene el idioma preferido del dispositivo.
    var language: String {
        return Locale.preferredLanguages.first ?? "en"
    }
    
    /// URL base del servicio web de películas.
    let baseURL = "https://api.themoviedb.org/3/movie/"
    
    /// Clave de API para acceder al servicio web de películas.
    let apiKey = "176de15e8c8523a92ff640f432966c9c"
    
    /// Método para realizar una solicitud y obtener una lista de películas populares.
    ///
    /// - Parameter completionHandler: El bloque de finalización que se ejecutará cuando se complete la solicitud.
    func fetch(completionHandler: @escaping CompletionHandler) {
        let urlString = "\(baseURL)popular?api_key=\(apiKey)&language=\(language)"
        
        // Se utiliza Alamofire (AF) para realizar una solicitud HTTP GET al urlString.
        // El bloque de finalización se ejecutará cuando se obtenga una respuesta.
        AF.request(urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else { return }
            
            // Se intenta decodificar los datos de la respuesta en un objeto MoviesDTO.
            // Si la decodificación tiene éxito, se llama al bloque de finalización con el objeto MoviesDTO.
            // Si la decodificación falla, se llama al bloque de finalización con un objeto MoviesDTO vacío.
            let arrayResponse = try? JSONDecoder().decode(MoviesDTO.self, from: data)
            
            completionHandler(arrayResponse ?? MoviesDTO())
        }
    }
    
    /// Método para obtener los detalles de una película específica.
    ///
    /// - Parameters:
    ///   - idMovie: El ID de la película.
    ///   - completionHandler: El bloque de finalización que se ejecutará cuando se complete la solicitud.
    func retrieveMovie(idMovie: Int, completionHandler: @escaping CompletionDetailsHandler) {
        let urlString = "\(baseURL)\(idMovie)?api_key=\(apiKey)&language=\(language)"
        
        // Se utiliza Alamofire (AF) para realizar una solicitud HTTP GET al urlString.
        // El bloque de finalización se ejecutará cuando se obtenga una respuesta.
        AF.request(urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else { return }
            
            // Se intenta decodificar los datos de la respuesta en un objeto MovieDetailDTO.
            // Si la decodificación tiene éxito, se llama al bloque de finalización con el objeto MovieDetailDTO.
            // Si la decodificación falla, se llama al bloque de finalización con un objeto MovieDetailDTO vacío.
            let response = try? JSONDecoder().decode(MovieDetailDTO.self, from: data)
            
            completionHandler(response ?? MovieDetailDTO())
        }
    }
    
    /// Método para obtener los videos de una película específica.
    ///
    /// - Parameters:
    ///   - movieId: El ID de la película.
    ///   - completionHandler: El bloque de finalización que se ejecutará cuando se complete la solicitud.
    func fetchVideos(for movieId: Int, completionHandler: @escaping CompletionVideosHandler) {
        let urlString = "\(baseURL)\(movieId)/videos?api_key=\(apiKey)&language=\(language)"
        
        AF.request(urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else { return }
            
            let videoResponse = try? JSONDecoder().decode(VideoModel.self, from: data)
            completionHandler(videoResponse ?? VideoModel(results: []))
        }
    }
}

// MARK: - Clousures

extension MoviesWebService {
    /// Definición de un bloque de finalización para la solicitud de películas.
    typealias CompletionHandler = (_ arrayMoviesDTO: MoviesDTO) -> Void
    
    /// Definición de un bloque de finalización para la solicitud de detalles de película.
    typealias CompletionDetailsHandler = (_ arrayMovies: MovieDetailDTO) -> Void
    
    /// Definición de un bloque de finalización para la solicitud de videos.
    typealias CompletionVideosHandler = (_ videoModel: VideoModel) -> Void
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
            self.video = true
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
            self.video = true
            self.vote_average = 0.0
            self.vote_count = 0
        }
    }
    
    /// Estructura para representar los detalles de un video.
    struct VideoResult: Decodable {
        let key: String?
        
        init(key: String) {
            self.key = key
        }
    }
    
    struct VideoDTO: Decodable {
        let keys: [String]
        
        init(keys: [String]) {
            self.keys = keys
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

