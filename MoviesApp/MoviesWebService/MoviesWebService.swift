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
            completionHandler(response ?? MovieDetailDTO.movideDetail())
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
  
        let results: [MovieDTO]?
     

        init() {
            self.results = []
    
        }
    }
    
    struct MovieDTO: Decodable {
        let id: Int?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Float?
        let poster_path: String?
        let release_date: String?
        let title: String?
        let video: Bool?
        let voteAverage: Float?
        let voteCount: Int?
    }
    
    struct MovieDetailDTO: Decodable {
        let backdropPath: String?
        let genres: [Genre]?
        let originalTitle, overview: String?
        let posterPath: String?
        let releaseDate: String?
        let voteAverage: Double?
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case genres
            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
        }
        
        static func movideDetail() -> Self {
            return Self(backdropPath: "", 
                        genres: [],
                        originalTitle: "",
                        overview: "",
                        posterPath: "",
                        releaseDate: "",
                        voteAverage: 0)
        }
    }

    // MARK: - Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }
}


