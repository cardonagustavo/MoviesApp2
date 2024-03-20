//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//
import UIKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    lazy var movieWebService = MoviesWebService()
    
    var movie: MovieDetail?
    var movieId: Int?
    var isFavoriteMovie = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
    
    private lazy var webServiceDetail = MoviesWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()

        self.navigationItem.title = "Details"
        
        // Configurar el botón de favoritos
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(favoritesButtonTapped))
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    private func createFavoriteIcon() -> UIImage {
        return UIImage(systemName: isFavoriteMovie ? "star.fill" : "star") ?? UIImage()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        isFavoriteMovie.toggle()
        updateFavoriteButtonImage()
        
        if isFavoriteMovie {
            // Agregar película a favoritos
            print("Película añadida a favoritos")
        } else {
            // Eliminar película de favoritos
            print("Película eliminada de favoritos")
        }
    }
    
    private func updateFavoriteButtonImage() {
        let image = createFavoriteIcon()
        navigationItem.rightBarButtonItem?.image = image
    }
    
    private func getWebServiceDetail() {
        self.webServiceDetail.retriveMovie(idMovie: movieId!) { [weak self] movieDetailDTO in
            let movieDetail = MovieDetail(detailDto: movieDetailDTO)
            self?.movie = movieDetail
            DispatchQueue.main.async {
                self?.detailView?.dataInjection(fromModel: movieDetail)
            }
        }
    }
}
