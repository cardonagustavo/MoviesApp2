//
//  SearchMoviesAdapterProtocol.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

/// Protocolo utilizado por el adaptador de búsqueda de películas para gestionar los datos y la funcionalidad de búsqueda.
protocol SearchMoviesAdapterProtocol {
    /// Fuente de datos que contiene las películas que se mostrarán en la búsqueda.
    var datasource: [Movies] { get set }
    
    /// Configura la barra de búsqueda utilizada para realizar búsquedas de películas.
    ///
    /// - Parameter searchBar: La barra de búsqueda que se va a configurar.
    func setSearchBar(_ searchBar: UISearchBar)
    
    /// Define el controlador de filtrado que se activará cuando se realice una búsqueda.
    ///
    /// - Parameter handler: El controlador de filtrado que manejará los resultados de la búsqueda.
    func didFilterHandler(_ handler: @escaping (_ result: [Any], _ message: String) -> Void )
}

