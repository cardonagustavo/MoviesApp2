//
//  ErrorSearchEstrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 24/03/24.
//

import UIKit

struct ErrorSearchEstrategy: ErrorStrategy {

    func showError(in view: UIView) {
        if let scrollView = view as? UIScrollView {
            // Crear y configurar la vista de error
            let errorView = ErrorCollectionViewCell.buildIn(scrollView as! UICollectionView, in: IndexPath(item: 0, section: 0), whit: "No se encontraron resultados")
            
            // Asegurarse de que la vista de error ocupe todo el contenido del scrollView
            errorView.frame = scrollView.bounds
            
            // Asegurarse de que la vista de error siempre esté detrás de otras vistas
            scrollView.addSubview(errorView)
            scrollView.sendSubviewToBack(errorView)
        } else {
            // Manejar otros tipos de vistas aquí
        }
    }
}

