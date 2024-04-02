//
//  DetailView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit

/// Protocolo para manejar la acción de tocar el botón de ver vídeo en la vista de detalle.
protocol DetailViewDelegate: AnyObject {
    func didTapWatchVideoButton()
}

/// Vista de detalle que muestra información sobre una película.
class DetailView: UIView {
    
    // MARK: - Properties
    
    /// Delegado para manejar la acción de tocar el botón de ver vídeo.
    weak var delegate: DetailViewDelegate?
    
    // MARK: - Outlets
    
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
    @IBOutlet weak var labelPlayTeaser: UILabel!
    @IBOutlet weak var buttonTeaserMovie: UIButton!
    
    // MARK: - Actions
    
    /// Método para manejar la acción de tocar el botón de ver vídeo.
    @IBAction func buttonWhatchVideo(_ sender: Any) {
        delegate?.didTapWatchVideoButton()
    }
    
    // MARK: - Private Properties
    
    /// Vista para mostrar la calificación de estrellas.
    private let starMaskView = StarsRank(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    // MARK: - Public Methods
    
    /// Método para formatear la lista de géneros de la película.
    ///
    /// - Parameter genres: Lista de géneros de la película.
    /// - Returns: Cadena formateada con la lista de géneros.
    func genresList(_ genres: [MoviesWebService.GenreDTO]) -> String {
        var list = ""
        genres.forEach { genre in
            list += "\u{2022} \(genre.name ?? "") "
        }
        return list
    }
    
    /// Método para inyectar datos de modelo en la vista.
    ///
    /// - Parameter movie: Objeto `MovieDetail` con la información de la película.
    func dataInjection(fromModel movie: MovieDetail) {
        labelTitle(movie)
        labelDate(movie)
        labelDescriptionText(movie)
        labelDescriptionTitleMethod()
        labelGenteresTitleMethod()
        labelListGeneresUpdate()
        updateViewContainerStars()
        labelPlayTeaserUpdate()
        stylesTeaserButton()
        
        // Configuración de la imagen de fondo
        imageDetailBackdrop(movie)
        
        // Configuración de la imagen de la película
        imageDetail(movie)
        
        // Configuración de la lista de géneros
        labelListGenere.text = genresList(movie.genres)
    }
    
    // MARK: - Private Methods
    
    /// Método para cargar y mostrar la imagen de fondo.
    ///
    /// - Parameter movie: Objeto `MovieDetail` con la información de la película.
    private func imageDetailBackdrop(_ movie: MovieDetail) {
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movie.backdrop_path
        
        if let url = URL(string: urlImage) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self, let imageData = data else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.imageBackdrop.image = image
                    
                    let blurEffect = UIBlurEffect(style: .dark)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = self.imageBackdrop.bounds
                    self.imageBackdrop.addSubview(blurView)
                }
            }.resume()
            self.imageMovie.layer.cornerRadius = 10
        }
    }
    
    /// Método para cargar y mostrar la imagen de la película.
    ///
    /// - Parameter movie: Objeto `MovieDetail` con la información de la película.
    private func imageDetail(_ movie: MovieDetail) {
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movie.poster_path
        if let url = URL(string: urlImage) {
            URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.imageMovie.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
    
    /// Método para configurar el título de la película.
    ///
    /// - Parameter movies: Objeto `MovieDetail` con la información de la película.
    private func labelTitle(_ movies: MovieDetail) {
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelTitle.textColor = .white
        labelTitle.text = movies.original_title
    }
    
    /// Método para configurar la fecha de lanzamiento de la película.
    ///
    /// - Parameter movie: Objeto `MovieDetail` con la información de la película.
    private func labelDate(_ movie: MovieDetail) {
        labelReleaseDate.text = " \(movie.formattedReleaseDateForFavorite)"
        labelReleaseDate.font = UIFont.italicSystemFont(ofSize: 16.0)
        labelReleaseDate.textColor = .lightGray
    }
    
    /// Método para actualizar el fondo del contenedor de estrellas.
    private func updateViewContainerStars() {
        viewContainerStars.backgroundColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    /// Método para configurar el texto de descripción de la película.
    ///
    /// - Parameter movie: Objeto `MovieDetail` con la información de la película.
    private func labelDescriptionText(_ movie: MovieDetail) {
        labelDescriptionText.text = movie.overview
        labelDescriptionText.textAlignment = .justified
        labelDescriptionText.font = UIFont.italicSystemFont(ofSize: 16.0)
        labelDescriptionText.textColor = .lightGray
    }
    
    /// Método para configurar el título de descripción de la película.
    private func labelDescriptionTitleMethod() {
        labelDescriptionTitle.text = StringsLocalizable.DetailsView.labelDescriptionTitle.localized()
        labelDescriptionTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
        labelDescriptionTitle.textColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    /// Método para configurar el título de géneros de la película.
    private func labelGenteresTitleMethod() {
        labelGeneresTitle.text = StringsLocalizable.DetailsView.labelGeneresTitle.localized()
        labelGeneresTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
        labelGeneresTitle.textColor = UIColor(named: "PrincipalInvertColorBackground")
    }
    
    /// Método para actualizar el texto de la lista de géneros.
    private func labelListGeneresUpdate() {
        labelListGenere.font = UIFont.italicSystemFont(ofSize: 16.0)
        labelListGenere.textColor = .lightGray
    }
    
    /// Método para actualizar el texto del botón de reproducir avance.
    private func labelPlayTeaserUpdate() {
        labelPlayTeaser.text = StringsLocalizable.DetailsView.labelPlayTeaser.localized()
        labelPlayTeaser.font = UIFont(name: "Helvetica-Bold", size: 15)
        labelPlayTeaser.textColor = .lightGray
    }
    
    /// Método para aplicar estilos al botón de reproducir avance.
    private func stylesTeaserButton() {
        buttonTeaserMovie.translatesAutoresizingMaskIntoConstraints = false

        let buttonSize: CGFloat = 100
        NSLayoutConstraint.activate([
            buttonTeaserMovie.widthAnchor.constraint(equalToConstant: buttonSize),
            buttonTeaserMovie.heightAnchor.constraint(equalToConstant: buttonSize)
        ])

        if let iconImage = UIImage(named: "PlayIcon.png") {
            buttonTeaserMovie.setImage(iconImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }

        buttonTeaserMovie.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        buttonTeaserMovie.imageView?.contentMode = .scaleAspectFill
    }
}
