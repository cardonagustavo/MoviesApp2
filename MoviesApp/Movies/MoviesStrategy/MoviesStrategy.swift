//
//  MoviesStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.
//

import Foundation

/// Protocolo para definir estrategias de obtención de datos de películas.
protocol MoviesStrategy {
    
    /// Método para obtener datos de películas a través de servicios web.
    mutating func getWebServiceStrategy()
    
}

