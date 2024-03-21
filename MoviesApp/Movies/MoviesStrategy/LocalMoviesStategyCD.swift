//  LocalMoviesStategyCD.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 21/03/24.

import Foundation
import CoreData
import UIKit

struct LocalMoviesStategyCD: MoviesStrategy {
    
    private var moviesView: MoviesView
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    func getWebServiceStrategy() {
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
    
        do {
          // 3. Ejecuta la solicitud de recuperación y guarda los resultados
          let favoriteMovies = try context.fetch(fetchRequest)
            self.moviesView.reloadData(favoriteMovies.toMoviesToFavoritesMovies)

        } catch {
          print("Error al recuperar películas: \(error)")
        }
    }

}
