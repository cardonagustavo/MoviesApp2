//
//  MoviesListSimpleAdapterProtocol.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import UIKit


//MARK: - Protocol
/// Protocolo utilizado por adaptadores de colección en la gestión de datos para vistas de películas.
protocol MoviesListAdapterProtocol {
    /// La fuente de datos que se utilizará para cargar las películas en la vista.
    var datasource: [Any] { get set }
    
    /// Establece la colección de vista utilizada para mostrar las películas.
    ///
    /// - Parameter collectionView: La colección de vista que se va a configurar.
    func setCollectionView(_ collectionView: UICollectionView)
    
    /// Define el controlador de selección que se activará cuando se seleccione una película.
    ///
    /// - Parameter handler: El controlador de selección que manejará la selección de películas.
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void)
}
