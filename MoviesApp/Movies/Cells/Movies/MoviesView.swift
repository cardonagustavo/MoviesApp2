
//  MoviesView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.


import UIKit

// Protocolo para la vista de películas
protocol MoviesViewDelegate: AnyObject {
    func moviesViewStartPullToRefresh(_ initView: MoviesView)
    func moviesView(_ initView: MoviesView, didSelectMovie movie: Movies)
}

// Vista de películas
class MoviesView: UIView {
    
    // Elementos de la vista
    private lazy var collectionViewMovies: UICollectionView = {
        let codeClvMovies = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        codeClvMovies.backgroundColor = .white
        codeClvMovies.showsVerticalScrollIndicator = false
        codeClvMovies.translatesAutoresizingMaskIntoConstraints = false
        codeClvMovies.keyboardDismissMode = .onDrag
        return codeClvMovies
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var customSearchBar: UISearchBar = {
        let customSearchBar = UISearchBar(frame: .zero)
        customSearchBar.translatesAutoresizingMaskIntoConstraints = false
        return customSearchBar
    }()
    
    weak var delegate: MoviesViewDelegate?
    private var listAdapter: MoviesListAdapterProtocol?
    private var searchAdapter: SearchMoviesAdapterProtocol?
    private var needsUsePullToRefresh: Bool = false
    
    // Inicializador
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
    
    // Configuración de adaptadores
    func setupAdapters() {
        self.listAdapter?.setCollectionView(self.collectionViewMovies)
        self.searchAdapter?.setSearchBar(self.customSearchBar)
        //        self.collectionViewMovies.addSubview(self.refreshControl)
        
        self.listAdapter?.didSelectHandler { movie in
            self.delegate?.moviesView(self, didSelectMovie: movie)
        }
        self.searchAdapter?.didFilterHandler { result in
            self.reloadCollectionView(result)
        }
        
        if self.needsUsePullToRefresh {
            self.collectionViewMovies.addSubview(self.refreshControl)
        }
    }
    
    // Mostrar o esconder el indicador de carga
    func showLoading(_ isShow: Bool) {
        if self.needsUsePullToRefresh {
            isShow ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
        }
    }
    
    // Manejar el "Pull to Refresh"
    @objc private func pullToRefresh(_ refreshControl: UIRefreshControl) {
        self.delegate?.moviesViewStartPullToRefresh(self)
    }
    
    // Recargar la colección de películas
    private func reloadCollectionView(_ datasource: [Any]) {
        self.listAdapter?.datasource = datasource
        self.collectionViewMovies.reloadData()
    }
    
    // Actualizar la vista con nuevos datos
    func reloadData(_ datasource: [Movies]) {
        self.searchAdapter?.datasource = datasource
        self.reloadCollectionView(datasource)
    }
    
    // Agregar elementos a la vista
    func addingElements() {
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
