//
//  DetailsViewController.swift
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
    var movieSelected: Movies?
    
    private lazy var webServiceDetail = MoviesWebService()
    private let sessionManager = SessionManager.standard // Instancia de SessionManager
    
    override func viewWillAppear(_ animated: Bool) {
        guard let movieToDisplay = self.movie else { return }
        
        if self.movie != nil {
            self.detailView?.dataInjection(fromModel: movieToDisplay)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebServiceDetail()
        setupNavigationBar()
    }
   
    private func setupNavigationBar() {
        let customButtonBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [customButtonBack]
        
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoritesButtonTapped))
        
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

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        //TODO: Add movies to favorites
    }
    
    @objc private func customButtonTappedLoguot() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sessionManager.logoutWithRememberme() // Llama al método de cierre de sesión desde SessionManager
        
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


