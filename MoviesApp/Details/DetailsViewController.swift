//  DetailViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
import UIKit
import CoreData
import AVKit

/// Controlador de vista para mostrar detalles de una película.
class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var detailView: DetailView? { self.view as? DetailView }
    var movie: MovieDetail?
    var videoKey: String?
    var movieId: Int?
    var isFavoriteMovie = false
    
    /// Contexto de CoreData para acceder a la base de datos local.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// Objeto para realizar llamadas a la API de películas.
    private lazy var webServiceDetail = MoviesWebService()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
        detailView?.delegate = self
        self.navigationItem.title = "Details"
    }
    
    // MARK: - Actions
    
    /// Agrega la película actual a la lista de favoritos.
    @objc private func addToFavorites() {
        guard let movieDetail = movie else { return }
        
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", movieDetail.id)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            
            if let _ = existingMovies.first {
                print(StringsLocalizable.Messages.AlreadyInFavorites.localized())
                return
            }
            
            let movieEntity = MoviesEntity(context: context)
            movieEntity.name_movie = movieDetail.title
            movieEntity.id = Int64(movieDetail.id)
            movieEntity.releaseDate_movie = movieDetail.release_date
            movieEntity.posterPath_movie = movieDetail.poster_path
            
            try context.save()
            isFavoriteMovie = true
            updateFavoriteButtonImage()
            print(StringsLocalizable.Messages.MovieAddedToFavorites.localized())
        } catch {
            print(StringsLocalizable.Messages.SearchOrSaveMovieError.localized() + "\(error)")
        }
    }
    
    /// Elimina la película actual de la lista de favoritos.
    @objc private func removeFromFavorites() {
        guard let movieDetail = movie else { return }
        
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", movieDetail.id)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            
            if let existingMovie = existingMovies.first {
                context.delete(existingMovie)
                
                try context.save()
                isFavoriteMovie = false
                updateFavoriteButtonImage()
                print(StringsLocalizable.Messages.MovieRemovedFromFavorites.localized())
            } else {
                print(StringsLocalizable.Messages.MovieIsNotInFavorites.localized())
            }
        } catch {
            print(StringsLocalizable.Messages.SearchOrSaveMovieError.localized() + "\(error)")
        }
    }
    
    /// Método para navegar hacia atrás en la vista.
    @objc private func buttonToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    /// Crea y configura el botón de favoritos en la barra de navegación.
    private func setupFavoriteButton() {
        let favoritesButtonImage = createFavoriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesButtonImage, style: .plain, target: self, action: isFavoriteMovie ? #selector(removeFromFavorites) : #selector(addToFavorites))
        navigationItem.rightBarButtonItem = favoritesButton
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(buttonToBack))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    /// Crea el icono de favoritos según el estado actual.
    private func createFavoriteIcon() -> UIImage {
        return UIImage(systemName: isFavoriteMovie ? "star.fill" : "star") ?? UIImage()
    }
    
    /// Actualiza la imagen del botón de favoritos según el estado actual.
    private func updateFavoriteButtonImage() {
        let image = createFavoriteIcon()
        navigationItem.rightBarButtonItem?.image = image
        navigationItem.rightBarButtonItem?.action = isFavoriteMovie ? #selector(removeFromFavorites) : #selector(addToFavorites)
    }
    
    /// Verifica el estado de favoritos de la película y actualiza el botón correspondiente.
    private func checkFavoriteStatusAndUpdateButton() {
        guard let movieId = self.movieId else { return }
        
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", movieId)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            isFavoriteMovie = !existingMovies.isEmpty
            setupFavoriteButton()
        } catch {
            print(StringsLocalizable.Messages.SearchOrSaveMovieError.localized() + "\(error)")
        }
    }
    
    /// Obtiene detalles de la película de la API web.
    private func getWebServiceDetail() {
        guard let movieId = movieId else { return }
        
        webServiceDetail.retrieveMovie(idMovie: movieId) { [weak self] movieDetailDTO in
            let movieDetail = MovieDetail(detailDto: movieDetailDTO)
            self?.movie = movieDetail
            DispatchQueue.main.async {
                self?.detailView?.dataInjection(fromModel: movieDetail)
                self?.checkFavoriteStatusAndUpdateButton()
                
                self?.webServiceDetail.fetchVideos(for: movieId) { videoModel in
                    // Verifica si hay resultados de video en el modelo
                    if !videoModel.results.isEmpty {
                        // Accede al primer resultado de video y obtén su key
                        let videoResult = videoModel.results.last
                        // Crea un objeto de tipo MoviesWebService.VideoResult
                        let webServiceVideoResult = MoviesWebService.VideoResult(key: videoResult?.key ?? "")
                        // Luego puedes usar este objeto para reproducir el video
                        self?.videoKey = webServiceVideoResult.key
                    } else {
                        print(StringsLocalizable.Messages.NotVideoForFilm.localized())
                    }
                }
            }
        }
    }
}

// MARK: - DetailViewDelegate

extension DetailViewController: DetailViewDelegate {
    /// Método llamado cuando se toca el botón de ver vídeo.
    func didTapWatchVideoButton() {
        guard let key = videoKey else {
            print(StringsLocalizable.Messages.NoVideoKeyAvailable.localized())
            return
        }
        
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
        UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
    }
}
