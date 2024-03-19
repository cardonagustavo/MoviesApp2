//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    lazy var movieWebService = MoviesWebService()
    
    var movie: MovieDetail?
    var movieId: Int?
    var isFavoriteMovie = false
    
    let user = SessionManager.standard.authenticationUserObtained()
    
    private lazy var webServiceDetail = MoviesWebService()
    private let sessionManager = SessionManager.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
        setupNavigationBar()
        self.navigationItem.title = "Details"
        self.isFavoriteMovie = self.validateIfMovieIsFavorite()
        self.addMovieToFavorites()
    }
    
    @objc private func addMovieToFavorites() {
        guard let movie = self.movie, !self.user.email.isEmpty else { return }
        
        var favorites = self.getFavoritesFromKeyChain()
        
        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
            // La película ya está en favoritos, la eliminamos
            favorites.remove(at: index)
        } else {
            // Añadimos la película a favoritos
            favorites.append(
                Favorite(
                    id: movie.id,
                    poster_path: movie.poster_path,
                    title: movie.title,
                    release_date: movie.release_date
                )
            )
        }
        
        // Guardamos la lista actualizada de favoritos en el Keychain
        do {
            let data = try JSONEncoder().encode(favorites)
            KeychainManager.standard.save(data, service: "userTest", account: "favorites-\(self.user.email)")
        } catch {
            print("Error saving favorites: \(error)")
        }
        
        // Actualizamos el estado de la película como favorita
        self.isFavoriteMovie = !self.isFavoriteMovie
        
        // Actualizamos la imagen del botón de favoritos en la barra de navegación
        let newImage = self.isFavoriteMovie ? UIImage(named: "favorite_icon") : UIImage(named: "unfavorite_icon")
        if let lastBarButtonItem = self.navigationItem.rightBarButtonItems?.last {
            lastBarButtonItem.image = newImage
        }
        
        // Podemos realizar animaciones u otras actualizaciones de la interfaz aquí si es necesario
    }


    private func setupNavigationBar() {
        let customButtonBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [customButtonBack]
        
        let favoritesImage = createFavriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesImage, style: .plain, target: self, action: #selector(favoritesButtonTapped))
        
        let customButton = UIButton(type: .custom)
        customButton.setImage(UIImage(named: "logout.png"), for: .normal)
        customButton.addTarget(self, action: #selector(customButtonTappedLoguot), for: .touchUpInside)
        customButton.contentMode = .scaleAspectFit // Ajusta el contenido del botón para que se ajuste correctamente
        
        let customBarButtonItem = UIBarButtonItem(customView: customButton)
        customBarButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false // Desactiva las restricciones automáticas
        
        if let customView = customBarButtonItem.customView {
            // Establece restricciones para el botón personalizado
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: 30), // Ancho fijo
                customView.heightAnchor.constraint(equalToConstant: 30) // Alto fijo
            ])
        }
        
        navigationItem.rightBarButtonItems = [customBarButtonItem, favoritesButton]
        
    }
    
    private func createFavriteIcon() -> UIImage {
        return UIImage(systemName: self.isFavoriteMovie ? "star.fill" : "star") ?? UIImage()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        if !self.user.email.isEmpty {
            var favorites = self.getFavoritesFromKeyChain()
            
            if (self.isFavoriteMovie) {
                favorites = favorites.filter { $0.id != self.movie?.id }
            } else {
                favorites.append(
                    Favorite(
                        id: self.movie?.id ?? 0,
                        poster_path: self.movie?.poster_path ?? "",
                        title: self.movie?.title ?? "",
                        release_date: self.movie?.release_date ?? ""
                    )
                )
            }
            
            do {
                let data = try JSONEncoder().encode(favorites)
                KeychainManager.standard.save(data, service: "userTest", account: "favorites-\(self.user.email)")
            } catch {}
            
            self.isFavoriteMovie = !self.isFavoriteMovie
            
            UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.navigationItem.rightBarButtonItems?.last?.image = self.createFavriteIcon()
            }, completion: nil)
        }
    }
    private func getFavoritesFromKeyChain() -> [Favorite] {
        return SessionManager.standard.retrieveFavoritesByUserLogged()
    }
    
    private func validateIfMovieIsFavorite() -> Bool {
        return self.getFavoritesFromKeyChain().filter { $0.id == self.movie?.id}.count > 0
    }
    
    
    @objc private func customButtonTappedLoguot() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sessionManager.logoutWithRememberme()
        
        if sessionManager.isUserRequestedRememberLogin() {
            let shortLoginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
            self.show(shortLoginViewController, sender: self)
        } else {
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
            self.show(loginViewController, sender: self)
        }
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
