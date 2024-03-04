//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView? { self.view as? DetailView }
    
    var movieId: Int?
    var movieSelected: Movies?
    var movieOverview: String?
    
    private lazy var webServiceDetail = MoviesWebService()

    
   override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.movieId)
       getWebServiceDetail()
    }
    
    private func getWebServiceDetail() {
        guard let movieId = movieId else { return }
        self.webServiceDetail.retriveMovies(idMovie: movieId) { movie in
            self.detailView?.imageDetailBackdrop(MovieDetails(dto: movie))
            self.detailView?.imageDetail(MovieDetails(dto: movie))
            self.detailView?.labelTitle(MovieDetails(dto: movie))
            self.detailView?.labeldDate(MovieDetails(dto: movie))
            self.detailView?.stackViewStars(MovieDetails(dto: movie))
            self.detailView?.labelDescriptionTitle(MovieDetails(dto: movie))
            self.detailView?.labelDescriptionText(MovieDetails(dto: movie))
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func viewContainer() {}
    func labelDescriptionTitle(_ movies: MovieDetails) { }
    func labelDescriptionText(_ movies: MovieDetails) { }
    func imageDetailBackdrop(_ movies: MovieDetails) { }
    func imageDetail(_ movies: MovieDetails) { }
    func labelTitle(_ movies: MovieDetails) { }
    func labeldDate(_ movies: MovieDetails) { }
    func stackViewStars(_ movies: MovieDetails) { }

}
