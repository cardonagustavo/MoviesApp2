//
//  searchMovieByInformationAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit

/// Clase que implementa el protocolo `SearchMoviesAdapterProtocol` para buscar películas utilizando información proporcionada.
class SearchMovieByInformationAdapter: NSObject, SearchMoviesAdapterProtocol {
    
    /// Fuente de datos que contiene las películas disponibles para la búsqueda.
    var datasource: [Movies] = []
    
    /// Controlador de filtrado que maneja los resultados de la búsqueda.
    private var didFilter: ((_ result: [Any]) -> Void)?
    
    /// Configura la barra de búsqueda para realizar búsquedas de películas.
    ///
    /// - Parameter searchBar: La barra de búsqueda que se va a configurar.
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
    
    /// Define el controlador de filtrado que se activará cuando se realice una búsqueda.
    ///
    /// - Parameter handler: El controlador de filtrado que manejará los resultados de la búsqueda.
    func didFilterHandler(_ handler: @escaping ([Any]) -> Void) {
        self.didFilter = handler
    }
}

// MARK: - Extension - UISearchBarDelegate
extension SearchMovieByInformationAdapter: UISearchBarDelegate {
    
    /// Método llamado cuando el texto en la barra de búsqueda cambia.
    ///
    /// - Parameters:
    ///   - searchBar: La barra de búsqueda en la que se ingresó el texto.
    ///   - searchText: El texto actualmente ingresado en la barra de búsqueda.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Se inicializa un arreglo vacío para almacenar los resultados de la búsqueda.
        var arrayResult: [Movies] = []
        // Se convierte el texto de búsqueda a minúsculas para una comparación sin distinción entre mayúsculas y minúsculas.
        let searchTextLowercased = searchText.lowercased()
        
        // Si el texto de búsqueda está vacío, se muestran todas las películas.
        if searchTextLowercased.isEmpty {
            arrayResult = self.datasource
        } else {
            // Se filtran las películas que contienen el texto de búsqueda en sus títulos.
            arrayResult = self.datasource.filter({ movies in
                let movieName = movies.title.lowercased()
                let searchName = searchTextLowercased
                return movieName.contains(searchName)
            })
        }
        
        // Se llama al controlador de filtrado para enviar los resultados de la búsqueda.
        self.didFilter?(arrayResult)
    }
}
