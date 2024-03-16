//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    lazy var movieWebService = MoviesWebService()
    
  var movie: Movie?
    
    var movieId: Int?
    var movieSelected: Movies?
 
    
    private lazy var webServiceDetail = MoviesWebService()
    
    override func viewWillAppear(_ animated: Bool) {
    guard let movieToDisplay = self.movie else { return }
        
        if self.movie != nil {
            self.detailView?.dataInjection(fromModel: movieToDisplay)
        }
        // let movieToDisplay = movie ?? Movie(id: 0, title: "Sin título", overview: "Sin descripción")
          
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
//       print(self.movieId)
//       getWebServiceDetail()
//       setupNavigationBar()
//       customButtonTappedLoguot()
       
    }
   
    /*
    private func setupNavigationBar() {
       
        let customButtonBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left.circle.fill"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItems = [customButtonBack]
        
        
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoritesButtonTapped))
        
        
       // let customButton = UIButton(type: .custom)
        let customButton = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(customButtonTappedLoguot))
       // customButton.addTarget(self, action: #selector(customButtonTappedLoguot), for: .touchUpInside)
       
        
      
        navigationItem.rightBarButtonItems = [customButton, favoritesButton]
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        //TODO: Add movies to favorites
    }
    
    @objc private func customButtonTappedLoguot() {
    }
    */
    
    private func getWebServiceDetail() {
        guard let movieId = movieId else { return }
        self.webServiceDetail.retriveMovies(idMovie: movieId) { movie in
            self.detailView?.labelDescriptionTitle.text = movie.original_title
            self.detailView?.labelDescriptionText.text = movie.overview
            self.detailView?.imageBackdrop.image = UIImage(named: "backdrop_path")
            self.detailView?.imageMovie.image = UIImage(named: "poster_path")
            self.detailView?.labelTitle.text = movie.original_title
        }
    }
}


