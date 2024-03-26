//  MoviesCollectionView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import UIKit


// MARK: - Class
class MoviesViewController: UIViewController {
    
    private var moviesView: MoviesView  //? { self.view as? MoviesView }
    private var strategy: MoviesStrategy //referencia a la estrategia que posee el contesto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.moviesView
        self.moviesView.delegate = self
        self.moviesView.setupAdapters()
        self.parent?.title = NSLocalizedString("MoviesApp", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.strategy.getWebServiceStrategy()
    }
    
    init(moviesView: MoviesView, strategy: MoviesStrategy) {
        self.strategy = strategy
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
        self.strategy.getWebServiceStrategy()
        
    }
    
}
