//
//  VideoModel.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/03/24.
//

import Foundation


struct VideoModel: Decodable {
    let results: [VideoResult]
}

struct VideoResult: Decodable {
    let key: String
}

/// Extensión del tipo Array para convertir una matriz de objetos VideoDTO a una matriz de objetos VideoResult.
extension Array where Element == VideoModel {
    
    /// Convierte una matriz de objetos VideoDTO a una matriz de objetos VideoResult.
    var toVideoResults: [VideoResult] {
        self.flatMap { $0.results }
    }
}


