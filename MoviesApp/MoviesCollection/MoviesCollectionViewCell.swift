//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//


import UIKit

// MARK: - Class
class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    
    fileprivate func updateDataWith(_ movies: Movies) {
//       self.imageMovie.image = movies.posterPath
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movies.posterPath
//            print(urlImage)
            if let url = URL(string: urlImage) {
              URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
                DispatchQueue.main.async {
//                    print("Here")
                 self.imageMovie.image = UIImage(data: imageData)
                    
                }
                  
              }.resume()
                self.labelName.text = movies.title
                self.labelDescription.text = movies.releaseDate
                
          }
    }
}


// MARK: - Extencion
extension MoviesCollectionViewCell {
    
    class var identifier: String { "MoviesCollectionViewCell" }
    
    class func buildIn(_ collectionView: UICollectionView, in indexPath: IndexPath, whit movies: Movies) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateDataWith(movies)
        return cell ?? Self()
    }
}
