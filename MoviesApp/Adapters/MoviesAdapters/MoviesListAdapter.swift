//
//  MoviesListAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/02/24.
//

import UIKit

//MARK: - class
/// Adaptador de colección utilizado para gestionar datos en vistas de películas.
class MoviesListAdapter: NSObject, MoviesListAdapterProtocol {
    
    /// Colección de vista que mostrará las películas.
    private unowned var collectionView: UICollectionView?
    
    /// Controlador de selección de películas.
    private var didSelect: ((_ movies: Movies) -> Void)?
    
    /// Fuente de datos que se utilizará para cargar las películas en la vista.
    var datasource = [Any]() {
        didSet {
            // Si el tipo de datos es [Movies], se configura el diseño de las películas; de lo contrario, se configura el diseño de error.
            self.datasource is [Movies] ? self.setMoviesLayout() : self.setErrorLayout()
        }
    }
    
    /// Establece la colección de vista utilizada para mostrar las películas.
    ///
    /// - Parameter collectionView: La colección de vista que se va a configurar.
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.dataSource = self
        self.setMoviesLayout()
        // Se registra el tipo de celda que se utilizará para mostrar películas y errores.
        self.collectionView?.register(UINib(nibName: "ErrorCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ErrorCollectionViewCell")
        self.collectionView?.register(UINib(nibName: "MoviesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
    
    /// Define el controlador de selección que se activará cuando se seleccione una película.
    ///
    /// - Parameter handler: El controlador de selección que manejará la selección de películas.
    func didSelectHandler(_ handler: @escaping (_ movies: Movies) -> Void ) {
        self.didSelect = handler
    }
    
    /// Configura el diseño de la vista cuando se muestran películas.
    func setMoviesLayout() {
        // Se define el tamaño del diseño de la celda en la colección de vista.
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        // Se define el tamaño del grupo y se crea un grupo horizontal con un solo elemento por fila.
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 1)
        group.interItemSpacing = .fixed(20)
        
        // Se crea un diseño de sección con el grupo definido anteriormente.
        let section = NSCollectionLayoutSection(group: group)
        
        // Se configuran los espaciados entre los elementos y grupos en la sección.
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        // Se crea un diseño de composición para la colección de vista y se aplica a la misma.
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
    }
    
    func setErrorLayout() {
        let LayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: LayoutSize)
        
        let layoutGrup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGrup, subitem: item, count: 1)
        group.interItemSpacing = .fixed(0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
        
    }
}

//MARK: - Extension - UICollectionViewDataSource
/// Extensión que adopta el protocolo UICollectionViewDataSource para proporcionar datos a una colección de vista.
extension MoviesListAdapter: UICollectionViewDataSource {
    
    /// Devuelve el número de elementos en la fuente de datos.
    ///
    /// - Parameters:
    ///   - collectionView: La colección de vista que contiene los datos.
    ///   - section: El índice de la sección en la colección de vista.
    /// - Returns: El número de elementos en la sección especificada.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count // Retorna la cantidad de elementos en la fuente de datos.
    }
    
    
    /// Devuelve una celda que representa un elemento específico en la colección de vista.
    ///
    /// - Parameters:
    ///   - collectionView: La colección de vista que contiene la celda.
    ///   - indexPath: La ubicación del elemento en la colección de vista.
    /// - Returns: Una celda que representa el elemento en la ubicación especificada.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row] // Obtiene el elemento en la ubicación especificada.
        
        // Verifica si el elemento es un mensaje de error o una película y devuelve la celda correspondiente.
        if let message = item as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, in: indexPath, whit: message) // Devuelve una celda de mensaje de error.
        } else {
            if  let movie = item as? Movies {
                return MoviesCollectionViewCell.buildIn(collectionView, in: indexPath, whit: movie) // Devuelve una celda de película.
            } else {
                return UICollectionViewCell() // Devuelve una celda vacía si el tipo de elemento no es reconocido.
            }
        }
        
    }
}

extension MoviesListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = self.datasource[indexPath.row] as? Movies else { return }
        self.didSelect?(movies)
        
    }
}
