//
//  VideoModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/03/24.
//

import Foundation

/// Estructura que representa el modelo de video obtenido de la API.
struct VideoModel: Decodable {
    let results: [VideoResult]
}

/// Estructura que representa un resultado de video obtenido de la API.
struct VideoResult: Decodable {
    let key: String
}

/// Extensión del tipo Array para convertir una matriz de objetos `VideoModel` a una matriz de objetos `VideoResult`.
extension Array where Element == VideoModel {
    
    /// Convierte una matriz de objetos `VideoModel` a una matriz de objetos `VideoResult`.
    var toVideoResults: [VideoResult] {
        self.flatMap { $0.results }
    }
}

