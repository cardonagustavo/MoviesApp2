//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 26/02/24.
//

import UIKit

 protocol MoviesViewDelegate: AnyObject {
    func moviesView(_ moviesView: MoviesView, didSelectMovies movies: Movies)
    
 func logoutButtonTapped()
}

class MoviesView: UIView {
    
    weak var delegate: MoviesViewDelegate?
    @IBOutlet private weak var collectionViewMovies: UICollectionView!
    
    var listAdapter: MoviesListAdapterProtocol =  MoviesListAdapter()
    func setupCustomButton() {
        
    }
    func setupAdapters() {
        self.listAdapter.setCollectionView(self.collectionViewMovies)
        
        self.listAdapter.didSelectHandler {movies in
            self.delegate?.moviesView(self, didSelectMovies: movies)
        }
    }
    
    func reloadData(_ datasource: [Movies]) {
        self.listAdapter.datasource = datasource
        self.collectionViewMovies.reloadData()
    }
    
    func logoutButtonTapped() {
        
    }
}
 

