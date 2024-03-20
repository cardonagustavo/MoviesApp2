//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//


import UIKit

// MARK: - Class
class FavoritesCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    
    fileprivate func updateDataWith(_ movies: Movies) {
//       self.imageMovie.image = movies.posterPath
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movies.poster_path
//            print(urlImage)
            if let url = URL(string: urlImage) {
              URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
                DispatchQueue.main.async {
//                    print("Here")
                 self.imageMovie.image = UIImage(data: imageData)
                    
                }
                  
              }.resume()
                self.labelName.text = movies.title
                
                
                self.labelReleaseDate.text = movies.formattedReleaseDateForFavorite
                self.labelReleaseDate.font = UIFont.italicSystemFont(ofSize: 16.0)
                self.labelReleaseDate.textColor = UIColor.lightGray
                
                
                self.imageMovie.layer.cornerRadius = 20
          }
    }
}


// MARK: - Extencion
extension FavoritesCollectionViewCell {
    
    class var identifier: String { "FavoritesCollectionViewCell" }
    
    class func buildIn(_ collectionView: UICollectionView, in indexPath: IndexPath, whit movies: Movies) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateDataWith(movies)
        return cell ?? Self()
    }
}
