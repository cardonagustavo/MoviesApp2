//  DetailViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    lazy var movieWebService = MoviesWebService()
    var movie: MovieDetail?
    var movieId: Int?
    var isFavoriteMovie = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var webServiceDetail = MoviesWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
    
        self.navigationItem.title = "Details"
        
        // Configurar el botón de favoritos
        setupFavoriteButton()
        
    }
    
    @objc private func addToFavorites() {
        guard let movieDetail = movie else { return }
        // Crea una instancia de tu entidad Movie en el contexto de CoreData
        let movieEntity = MoviesEntity(context: context)
        // Configura las propiedades de la entidad
        movieEntity.name_movie = movieDetail.title
        movieEntity.id = Int64(movieDetail.id)
        movieEntity.releaseDate_movie = movieDetail.release_date
        movieEntity.posterPath_movie = movieDetail.poster_path
        
        // Guarda el contexto para persistir los cambios en la base de datos
        do {
            try context.save()
            // Cambia la imagen del botón para mostrar que la película es favorita
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            // Muestra algún mensaje o feedback al usuario
            print("La película ha sido agregada a favoritos.")
        } catch {
            // Manejar el error aquí
            print("Error al guardar la película en favoritos: \(error)")
        }
    }

    private func setupFavoriteButton() {
        let favoritesButtonImage = createFavoriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesButtonImage, style: .plain, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = favoritesButton
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(buttonToBack))
            navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func buttonToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createFavoriteIcon() -> UIImage {
        return UIImage(systemName: isFavoriteMovie ? "star.fill" : "star") ?? UIImage()
    }


    private func updateFavoriteButtonImage() {
        let image = createFavoriteIcon()
        navigationItem.rightBarButtonItem?.image = image
    }
    
    private func getWebServiceDetail() {
        guard let movieId = movieId else { return }
        
        webServiceDetail.retriveMovie(idMovie: movieId) { [weak self] movieDetailDTO in
            let movieDetail = MovieDetail(detailDto: movieDetailDTO)
            self?.movie = movieDetail
            DispatchQueue.main.async {
                self?.detailView?.dataInjection(fromModel: movieDetail)
            }
        }
    }
}
