//  MoviesCollectionView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import UIKit


// MARK: - Class
class MoviesViewController: UIViewController {
    
    private var moviesView: MoviesView  //? { self.view as? MoviesView }
    
    private lazy var webService = MoviesWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.moviesView
        self.moviesView.delegate = self
        self.moviesView.setupAdapters()
        self.getWebService()
        self.parent?.title = NSLocalizedString("MoviesApp", comment: "")
    }
    
    private func getWebService() {
        self.moviesView.showLoading(true)
        self.webService.fetch { arrayMoviesDTO in
            guard let movies = arrayMoviesDTO.results?.toMovies else { return }
            self.moviesView.reloadData(movies)
            self.moviesView.showLoading(false)
        }
    }
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
     private func navigateToDetailViewWithMovie(_ movie: Movies) {
           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailViewController.movieId = movie.id
           self.navigationController?.pushViewController(detailViewController, animated: true)
        
       }
    
}
  
//MARK: - Extension
extension MoviesViewController: MoviesViewDelegate {

    func moviesView(_ initView: MoviesView, didSelectMovie movie: Movies) {
        print("Navigation")
        self.navigateToDetailViewWithMovie(movie)
    
    }
    
    func moviesViewStartPullToRefresh(_ initView: MoviesView) {
        self.getWebService()
        
    }
    
}



