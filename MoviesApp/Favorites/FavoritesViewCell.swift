//
//  FavoritesViewCell.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 4/03/24.
//

import UIKit

class FavoritesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieReleaseDate: UILabel!
    @IBOutlet weak var stackViewStars: UIStackView!
    
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
                self.labelMovieName.text = movies.title
                self.labelMovieReleaseDate.text = movies.releaseDate
                self.imageMovie.layer.cornerRadius = 20
          }
    }
}
