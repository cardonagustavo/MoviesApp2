//  MoviesCollectionView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.

import UIKit

/// View controller responsible for displaying movies.
class MoviesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var moviesView: MoviesView
    private var strategy: MoviesStrategy
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the custom moviesView as the main view
        self.view = self.moviesView
        
        // Set delegate for handling interactions with the moviesView
        self.moviesView.delegate = self
        
        // Setup adapters for the moviesView
        self.moviesView.setupAdapters()
        
        // Set parent title
        self.parent?.title = NSLocalizedString("MoviesApp", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch movie data using the selected strategy
        self.strategy.getWebServiceStrategy()
    }
    
    // MARK: - Initialization
    
    init(moviesView: MoviesView, strategy: MoviesStrategy) {
        self.strategy = strategy
        self.moviesView = moviesView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    /// Navigate to the detail view controller with the selected movie.
    private func navigateToDetailViewWithMovie(_ movie: Movies) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.movieId = movie.id
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - MoviesViewDelegate Extension

extension MoviesViewController: MoviesViewDelegate {
    
    /// Handles the selection of a movie from the moviesView.
    func moviesView(_ initView: MoviesView, didSelectMovie movie: Movies) {
        // Navigate to the detail view controller with the selected movie
        self.navigateToDetailViewWithMovie(movie)
    }
    
    /// Handles the pull-to-refresh action triggered by the moviesView.
    func moviesViewStartPullToRefresh(_ initView: MoviesView) {
        // Fetch movie data using the selected strategy
        self.strategy.getWebServiceStrategy()
    }
}
