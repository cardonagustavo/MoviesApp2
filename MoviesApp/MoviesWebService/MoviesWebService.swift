//  MoviesWebServise.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import Foundation
import Alamofire

//MARK: - Web Service
class MoviesWebService {
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    
    func fetch(completionHandler: @escaping CompletionHandler) {
        AF.request(urlString, method: .get).response {  dataResponse in
            guard let data = dataResponse.data else {return}
            //            guard let dataTest = try? JSONSerialization.jsonObject(with: data) else { return }
            //            print(dataTest)
            let arrayResponse = try? JSONDecoder().decode(MoviesDTO.self, from: data)
            completionHandler(arrayResponse ?? MoviesDTO())
        }
    }
    
    func retriveMovies(idMovie: Int, completionHandler: @escaping CompleticionDetailsHandler) {
        let moviesDetails = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
        AF.request(moviesDetails, method: .get).response { dataResponse in
            guard let data = dataResponse.data else {return}
            guard let dataTest = try? JSONSerialization.jsonObject(with: data) else { return }
           print(dataTest)
            let response = try? JSONDecoder().decode(MovieDetailDTO.self, from: data)
            completionHandler(response ?? MovieDetailDTO())
        }
    }
}

//MARK: - Clousures

extension MoviesWebService {
    typealias CompletionHandler = (_ arrayMoviesDTO: MoviesDTO) -> Void
    typealias CompleticionDetailsHandler = (_ arrayMovies: MovieDetailDTO) -> Void
}

//MARK: - DTO

extension MoviesWebService {
    
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
    struct GenreDTO: Decodable {
        let id: Int?
        let name: String?
    }
    
    // MARK: - ProducerCompany
    struct ProducerCompanyDTO: Decodable {
        let id: Int?
        let logo_path: String?
        let name, origin_country: String?
    }
    
    // MARK: - ProducerCountry
    struct ProducerCountryDTO: Codable {
        let name: String?
    }
    
    // MARK: - Language
    struct LanguageDTO: Codable {
        let english_name, name: String?
    }
    
}

