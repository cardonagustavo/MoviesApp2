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
    
    var movie: Movie?
    var movieId: Int?
    var isFavoriteMovie = false
    let user = SessionManager.standard.authenticationUserObtained()
    
    private lazy var webServiceDetail = MoviesWebService()
    private let sessionManager = SessionManager.standard // Instancia de SessionManager
    
    override func viewWillAppear(_ animated: Bool) {
        guard let movieToDisplay = self.movie else { return }
        self.detailView?.dataInjection(fromModel: movieToDisplay)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
        setupNavigationBar()
        self.navigationItem.title = "Details"
        self.isFavoriteMovie = self.validateIfMovieIsFavorite()
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
                keyChangeManager.standard.save(data, service: "userTest.com", account: "favorites-\(self.user.email)")
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
        guard let movieId = movieId else { return }
        self.webServiceDetail.retriveMovies(idMovie: movieId) { movie in
            // Actualización de la vista con los detalles de la película
        }
    }
}


