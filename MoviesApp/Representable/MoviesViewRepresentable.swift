//
//  MoviesViewRepresentable.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import SwiftUI

// MARK: - Movies View Representable

/// Representa una vista de películas como un controlador de vista UIKit en SwiftUI.
struct MoviesViewRepresentable: UIViewControllerRepresentable {
    
    /// Actualiza el controlador de vista cuando cambia el contexto.
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No es necesario implementar ninguna actualización aquí.
    }
    
    /// Crea y configura el controlador de vista inicial.
    func makeUIViewController(context: Context) -> some UIViewController {
        // Retorna un controlador de vista de películas construido con la lista de películas populares.
        return MoviesViewController.buildMovies()
    }
}

// MARK: - Cars View Previews

/// Proveedor de vistas previas para la vista de películas.
struct MoviesViewPreviews: PreviewProvider {
    
    /// Crea vistas previas de la vista de películas.
    static var previews: some View {
        // Retorna la vista representable de películas para previsualización.
        return MoviesViewRepresentable()
    }
}

