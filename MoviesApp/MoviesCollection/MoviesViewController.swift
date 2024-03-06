//  MoviesCollectionView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import UIKit


// MARK: - Class
class MoviesViewController: UIViewController {
    
    private var moviesView: MoviesView? { self.view as? MoviesView }
    
    private lazy var webService = MoviesWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesView?.delegate = self
        self.moviesView?.setupAdapters()
        self.getWebService()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    private func getWebService() {
        self.webService.fetch { arrayMoviesDTO in
            guard let movies = arrayMoviesDTO.results?.toMovies else { return }
            self.moviesView?.reloadData(movies)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            guard let destinationViewController = segue.destination as? DetailViewController else { return }
            guard let moviesSelect = sender as? Movies else { return }
            destinationViewController.movieId = moviesSelect.id
        }
    }
}
  
//MARK: - Extension
extension MoviesViewController: MoviesViewDelegate {
    @objc func logoutButtonTapped() {
        
    }
    
    func moviesView(_ moviesView: MoviesView, didSelectMovies movies: Movies) {
        print("seleccionado")
        self.performSegue(withIdentifier: "DetailViewController", sender: movies)
    }
}


