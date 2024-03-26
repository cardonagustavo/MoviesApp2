//
//  ErrorFavoritesListStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 24/03/24.
//

import UIKit

struct ErrorFavoritesListStrategy: ErrorStrategy {
    func showError(in view: UIView) {
        // Verifica si la vista es una UICollectionView
        if let collectionView = view as? UICollectionView {
            collectionView.backgroundView = ErrorCollectionViewCell.buildIn(collectionView, in: IndexPath(item: 0, section: 0), whit: "La lista de favoritos está vacía")
        } else {
            print("Error: View is not a UICollectionView")
        }
    }
}


