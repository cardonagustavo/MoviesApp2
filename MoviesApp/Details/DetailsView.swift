//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit



protocol DetailViewProtocol {
    func dataInjection(fromModel movie: Movie)
}

//MARK: - Class
class DetailView: UIView {
    
    
    @IBOutlet weak var viewContainerTop: UIView!    
    @IBOutlet weak var viewContainerStars: UIView!
    
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelGeneres: UILabel!
    @IBOutlet weak var labelListGenere: UILabel!
    @IBOutlet weak var labelDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescriptionText: UILabel!
    
    private let starMaskView = StarsRank(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
}


extension DetailView {
    func genresList(_ genres: [MoviesWebService.GenreDTO]) -> String {
        var list = ""

        genres.forEach({ genre in
            list += "\u{2022} \(genre.name ?? "") "
        })
        return list
    }
    
 func dataInjection(fromModel movie: Movie) {
     self.labelTitle.text = movie.title
     self.labelReleaseDate.text = movie.release_date
     self.starMaskView.progressView.progress = (movie.vote_average / 10)
     self.viewContainerStars.addSubview(starMaskView)
     self.labelListGenere.text = self.genresList(movie.genres)
     self.labelDescriptionText.text = movie.overview
        
        func imageDetailBackdrop(_ movie: Movie) {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            let urlImage = baseURLImage + movie.backdrop_path
            
            if let url = URL(string: urlImage) {
                URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let self = self, let imageData = data else { return }
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.imageBackdrop.image = image
                        
                        //                    let fadeView = UIView(frame: self.imageBackdrop.bounds)
                        //                    fadeView.backgroundColor = UIColor.black.withAlphaComponent(1)
                        //                    self.imageBackdrop.addSubview(fadeView)
                        
                        let blurEffect = UIBlurEffect(style: .light)
                        let blurView = UIVisualEffectView(effect: blurEffect)
                        blurView.frame = self.imageBackdrop.bounds
                        self.imageBackdrop.addSubview(blurView)
                    }
                }.resume()
            }
        }
        
        func imageDetail(_ movie: Movie) {
            //        self.imageMovie.image = movies.posterPath
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            let urlImage = baseURLImage + movie.poster_path
            if let url = URL(string: urlImage) {
                URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
                    DispatchQueue.main.async {
                        //                    print("Here")
                        self.imageMovie.image = UIImage(data: imageData)
                        
                    }
                }.resume()
            }
        }
        
        func labelTitle(_ movie: Movie) {
            self.labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.labelTitle.textColor = UIColor.white
            self.labelTitle.text = movie.original_title
        }
        func labeldDate(_ movie: Movie) {
            self.labelReleaseDate.text = "Fecha de lanzamiento: \(movie.release_date)"
            self.labelReleaseDate.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            self.labelReleaseDate.textColor = UIColor.white
        }
        
        func starsView() {
            
        }
        
        func labelGeneresMovie(_ movie: Movie) {
            self.labelGeneres.text = self.genresList(movie.genres)
        }
        
        func labelDescriptionTitle(_ movie: Movie) {
            self.labelDescriptionTitle.text = "Description:"
            self.labelDescriptionTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
            self.labelDescriptionTitle.textColor = UIColor.black
        }
        func labelDescriptionText(_ movie: Movie) {
            self.labelDescriptionText.text = movie.overview
            self.labelDescriptionText.textAlignment = .justified
            self.labelDescriptionText.font = UIFont(name: "thaoma", size: 16)
            self.labelDescriptionText.textColor = UIColor.darkGray
        }
        
    }
}

