//  MoviesCollectionViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import UIKit

/// A custom UICollectionViewCell to display favorite movie information.
class FavoritesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!
    
    // MARK: - Public Methods
    
    /// Updates the cell's UI with favorite movie data.
    ///
    /// - Parameter movies: The movie object containing information to be displayed.
    fileprivate func updateDataWith(_ movies: Movies) {
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movies.poster_path
        if let url = URL(string: urlImage) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self,
                      let imageData = data else { return }
                DispatchQueue.main.async {
                    self.imageMovie.image = UIImage(data: imageData)
                }
            }.resume()
        }
        labelName.text = movies.title
        
        // Set up release date label
        labelReleaseDate.text = movies.formattedReleaseDateForFavorite
        labelReleaseDate.font = UIFont.italicSystemFont(ofSize: 16.0)
        labelReleaseDate.textColor = UIColor.lightGray
        
        // Set up image view
        imageMovie.layer.cornerRadius = 20
    }
}

// MARK: - Extension

extension FavoritesCollectionViewCell {
    
    /// The reusable cell identifier.
    class var identifier: String { "FavoritesCollectionViewCell" }
    
    /// Builds a `FavoritesCollectionViewCell` and configures it with movie data.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - movies: The movie object containing information to be displayed.
    /// - Returns: A configured `FavoritesCollectionViewCell`.
    class func buildIn(_ collectionView: UICollectionView, at indexPath: IndexPath, with movies: Movies) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self else {
            return Self()
        }
        cell.updateDataWith(movies)
        return cell
    }
}
