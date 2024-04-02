//
//  ApiMoviesStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.
//

import Foundation

/// Estructura que implementa la estrategia de obtención de datos de películas a través de un servicio web.
struct ApiMoviesStrategy: MoviesStrategy {
    
    /// Vista de películas donde se mostrarán los datos obtenidos.
    private var moviesView: MoviesView
    
    /// Instancia del servicio web para obtener datos de películas.
    private lazy var webService = MoviesWebService()
    
    /// Inicializador de la estrategia de obtención de datos.
    /// - Parameter moviesView: Vista de películas donde se mostrarán los datos obtenidos.
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    /// Método para obtener datos de películas a través del servicio web.
    mutating func getWebServiceStrategy() {
        // Muestra el indicador de carga
        self.moviesView.showLoading(true)
        
        // Realiza la llamada al servicio web para obtener datos de películas
        self.webService.fetch { [self] arrayMoviesDTO in
            // Convierte los datos obtenidos en objetos de tipo Movie
            let movies = arrayMoviesDTO.results?.toMovies
            
            // Actualiza la vista de películas con los datos obtenidos
            self.moviesView.reloadData(movies ?? [], message: "servicio no disponible")
            
            // Oculta el indicador de carga
            self.moviesView.showLoading(false)
        }
    }
}
