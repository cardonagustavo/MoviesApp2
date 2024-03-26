//  DetailViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
import UIKit
import CoreData
class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    var movie: MovieDetail?
    var movieId: Int?
    var isFavoriteMovie = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var webServiceDetail = MoviesWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
        self.navigationItem.title = "Details"
    }
    
    @objc private func addToFavorites() {
        guard let movieDetail = movie else { return }
        
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", movieDetail.id)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            
            if let _ = existingMovies.first {
                print("La película ya está en favoritos.")
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
            print("La película ha sido agregada a favoritos.")
        } catch {
            print("Error al buscar o guardar la película en favoritos: \(error)")
        }
    }
    
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
                print("La película ha sido eliminada de favoritos.")
            } else {
                print("La película no está en favoritos.")
            }
        } catch {
            print("Error al buscar la película en favoritos: \(error)")
        }
    }
    
    private func setupFavoriteButton() {
        let favoritesButtonImage = createFavoriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesButtonImage, style: .plain, target: self, action: isFavoriteMovie ? #selector(removeFromFavorites) : #selector(addToFavorites))
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
        navigationItem.rightBarButtonItem?.action = isFavoriteMovie ? #selector(removeFromFavorites) : #selector(addToFavorites)
    }
    
    private func checkFavoriteStatusAndUpdateButton() {
        guard let movieId = self.movieId else { return }
        
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", movieId)
        
        do {
            let existingMovies = try context.fetch(fetchRequest)
            isFavoriteMovie = !existingMovies.isEmpty
            setupFavoriteButton()
        } catch {
            print("Error al buscar la película en favoritos: \(error)")
        }
    }
    
    private func getWebServiceDetail() {
        guard let movieId = movieId else { return }
        
        webServiceDetail.retrieveMovie(idMovie: movieId) { [weak self] movieDetailDTO in
            let movieDetail = MovieDetail(detailDto: movieDetailDTO)
            self?.movie = movieDetail
            DispatchQueue.main.async {
                self?.detailView?.dataInjection(fromModel: movieDetail)
                self?.checkFavoriteStatusAndUpdateButton()
            }
        }
    }
}
