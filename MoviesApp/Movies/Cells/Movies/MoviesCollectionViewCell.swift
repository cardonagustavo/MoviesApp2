//
//  MoviesCollectionViewCell.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//
import UIKit

// MARK: - Class
class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelReleaseData: UILabel!
    @IBOutlet weak var viewContainerStars: UIView!
    
    let starkViewMask = StarsRank(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    
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
            self.labelMovieName.text = movies.titleNil
            self.labelMovieName.textColor = UIColor(named: "PrincipalInvertBackground")
            
            self.imageMovie.layer.cornerRadius = self.viewContainer.layer.cornerRadius
            
            self.viewContainer.layer.borderWidth = 1
            self.viewContainer.layer.borderColor = UIColor(named: "PrincipalInvertBackground")?.cgColor
            self.viewContainer.layer.cornerRadius = 10
            self.viewContainer.clipsToBounds = true
            
            
            self.labelReleaseData.text = NSLocalizedString(movies.formattedReleaseDateForMovies, comment: "Release Date")
            self.labelReleaseData.font = UIFont.italicSystemFont(ofSize: 16.0)
            self.labelReleaseData.textColor = UIColor.lightGray
            //                self.labelReleaseData.textColor = UIColor(named: "PrincipalInvertBackground")
        }
        self.starkViewMask.progressView.progress = (movies.vote_average / 10)
        self.viewContainerStars.addSubview(starkViewMask)
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
