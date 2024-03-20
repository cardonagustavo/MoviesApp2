//
//  DetailView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit


//MARK: - Class
class DetailView: UIView {
    
    
    @IBOutlet weak var viewContainerTop: UIView!
    @IBOutlet weak var viewContainerStars: UIView!
    
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelGeneresTitle: UILabel!
    @IBOutlet weak var labelListGenere: UILabel!
    @IBOutlet weak var labelDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescriptionText: UILabel!
    
    private let starMaskView = StarsRank(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    func genresList(_ genres: [MoviesWebService.GenreDTO]) -> String {
        var list = ""
        genres.forEach({ genre in
            list += "\u{2022} \(genre.name ?? "") "
        })
        return list
    }
    
    func dataInjection(fromModel movie: MovieDetail) {
        self.labelTitle.text = movie.title
        self.labelReleaseDate.text = movie.formattedReleaseDateForFavorite
        self.starMaskView.progressView.progress = (movie.vote_average / 10)
        self.viewContainerStars.addSubview(starMaskView)
        self.labelListGenere.text = self.genresList(movie.genres)
        self.labelDescriptionText.text = movie.overview
        
        self.imageDetailBackdrop(movie)
        self.imageDetail(movie)
        self.labelTitle(movie)
        self.labelDate(movie)
        self.labelDescriptionText(movie)
        self.labelDescriptionTitleMethod()
        self.labelGenteresTitleMethod()
        self.labelListGeneresUpdate()
        self.updateViewContainerStars()
        
    }
    
    func imageDetailBackdrop(_ movie: MovieDetail) {
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
                    
                    let blurEffect = UIBlurEffect(style: .dark)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = self.imageBackdrop.bounds
                    self.imageBackdrop.addSubview(blurView)
                }
            }.resume()
            self.imageMovie.layer.cornerRadius = 10
        }
    }
    
    func imageDetail(_ movie: MovieDetail) {
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
    
    func labelTitle(_ movies: MovieDetail) {
        self.labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        self.labelTitle.textColor = UIColor.white
        self.labelTitle.text = movies.original_title
    }
    func labelDate(_ movie: MovieDetail) {
        self.labelReleaseDate.text = "Fecha de lanzamiento: \(movie.release_date)"
        self.labelReleaseDate.font = UIFont.italicSystemFont(ofSize: 16.0)
        self.labelReleaseDate.textColor = UIColor.lightGray
    }
    
    func updateViewContainerStars() {
        self.viewContainerStars.backgroundColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    func labelDescriptionText(_ movie: MovieDetail) {
        self.labelDescriptionText.text = movie.overview
        self.labelDescriptionText.textAlignment = .justified
        self.labelDescriptionText.font = UIFont.italicSystemFont(ofSize: 16.0)
        self.labelDescriptionText.textColor = UIColor.lightGray
    }
    
    func labelDescriptionTitleMethod() {
        self.labelDescriptionTitle.text = "Description:"
        self.labelDescriptionTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
        self.labelDescriptionTitle.textColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    func labelGenteresTitleMethod() {
        self.labelGeneresTitle.text = "Generos:"
        self.labelGeneresTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
        self.labelGeneresTitle.textColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    func labelListGeneresUpdate() {
        self.labelListGenere.font = UIFont.italicSystemFont(ofSize: 16.0)
        self.labelListGenere.textColor = UIColor.lightGray
    }
    
}

