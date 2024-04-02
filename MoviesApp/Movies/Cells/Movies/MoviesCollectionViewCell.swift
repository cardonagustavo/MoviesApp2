//  MoviesCollectionViewCell.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
import UIKit

/// A custom UICollectionViewCell to display movie information.
class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var labelMovieName: UILabel!
    @IBOutlet private weak var labelReleaseData: UILabel!
    @IBOutlet private weak var viewContainerStars: UIView!
    
    // MARK: - Properties
    
    private let starkViewMask = StarsRank(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    // MARK: - Public Methods
    
    /// Updates the cell's UI with movie data.
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
        labelMovieName.text = movies.titleNil
        labelMovieName.textColor = UIColor(named: "PrincipalInvertBackground")
        
        // Set up movie container view
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor(named: "PrincipalInvertBackground")?.cgColor
        viewContainer.layer.cornerRadius = 10
        viewContainer.clipsToBounds = true
        
        // Set up release date label
        labelReleaseData.text = NSLocalizedString(movies.formattedReleaseDateForMovies, comment: "")
        labelReleaseData.font = UIFont.italicSystemFont(ofSize: 16.0)
        labelReleaseData.textColor = UIColor.lightGray
        
        // Configure star rating view
        starkViewMask.progressView.progress = (movies.vote_average / 10)
        viewContainerStars.addSubview(starkViewMask)
    }
}

// MARK: - Extension

extension MoviesCollectionViewCell {
    
    /// The reusable cell identifier.
    class var identifier: String { "MoviesCollectionViewCell" }
    
    /// Builds a `MoviesCollectionViewCell` and configures it with movie data.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view in which the cell will be displayed.
    ///   - indexPath: The index path of the cell.
    ///   - movies: The movie object containing information to be displayed.
    /// - Returns: A configured `MoviesCollectionViewCell`.
    class func buildIn(_ collectionView: UICollectionView, at indexPath: IndexPath, with movies: Movies) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self else {
            return Self()
        }
        cell.updateDataWith(movies)
        return cell
    }
}
