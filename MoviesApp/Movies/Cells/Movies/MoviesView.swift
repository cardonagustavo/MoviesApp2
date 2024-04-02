
//  MoviesView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.


import UIKit

/// Protocol to handle interactions with the MoviesView.
protocol MoviesViewDelegate: AnyObject {
    func moviesViewStartPullToRefresh(_ initView: MoviesView)
    func moviesView(_ initView: MoviesView, didSelectMovie movie: Movies)
}

/// Custom view for displaying movies.
class MoviesView: UIView {
    
    // MARK: - Properties
    
    private lazy var collectionViewMovies: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .principalColorBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var customSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    weak var delegate: MoviesViewDelegate?
    private var listAdapter: MoviesListAdapterProtocol?
    private var searchAdapter: SearchMoviesAdapterProtocol?
    private var needsUsePullToRefresh: Bool = false
    
    // MARK: - Initialization
    
    init(listAdapter: MoviesListAdapterProtocol, searchAdapter: SearchMoviesAdapterProtocol, addPullToRefresh:  Bool) {
        self.listAdapter = listAdapter
        self.searchAdapter = searchAdapter
        super.init(frame: .zero)
        self.addingElements()
        self.needsUsePullToRefresh = addPullToRefresh
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addingElements()
    }
    
    // MARK: - Public Methods
    
    /// Configures the adapters for the MoviesView.
    func setupAdapters() {
        self.listAdapter?.setCollectionView(self.collectionViewMovies)
        self.searchAdapter?.setSearchBar(self.customSearchBar)
        
        self.listAdapter?.didSelectHandler { movie in
            self.delegate?.moviesView(self, didSelectMovie: movie)
        }
        self.searchAdapter?.didFilterHandler { result, message in
            self.reloadCollectionView(result, message: message)
        }
        
        if self.needsUsePullToRefresh {
            self.collectionViewMovies.addSubview(self.refreshControl)
        }
    }
    
    /// Shows or hides the loading indicator.
    ///
    /// - Parameter isShow: A Boolean value indicating whether to show the loading indicator.
    func showLoading(_ isShow: Bool) {
        if self.needsUsePullToRefresh {
            isShow ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Private Methods
    
    /// Handles pull-to-refresh action.
    @objc private func pullToRefresh(_ refreshControl: UIRefreshControl) {
        self.delegate?.moviesViewStartPullToRefresh(self)
    }
    
    /// Reloads the collection view with new data.
    private func reloadCollectionView(_ datasource: [Any], message: String) {
        self.listAdapter?.datasource = datasource.count == 0 ? [message] : datasource
        self.collectionViewMovies.reloadData()
    }
    
    // MARK: - Data Handling
    
    /// Reloads the view with new movie data.
    ///
    /// - Parameters:
    ///   - datasource: The array of movies to display.
    ///   - message: The message to display when there are no movies.
    func reloadData(_ datasource: [Movies], message: String) {
        self.searchAdapter?.datasource = datasource
        self.reloadCollectionView(datasource, message: "Aun no agregas peliculas a favoritos")
    }
    
    // MARK: - UI Setup
    
    /// Adds subviews to the view and sets up constraints.
    private func addingElements() {
        self.addSubview(self.collectionViewMovies)
        self.addSubview(self.customSearchBar)
        
        NSLayoutConstraint.activate([
            self.customSearchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.customSearchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.customSearchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.collectionViewMovies.topAnchor.constraint(equalTo: self.customSearchBar.bottomAnchor),
            self.collectionViewMovies.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionViewMovies.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionViewMovies.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
