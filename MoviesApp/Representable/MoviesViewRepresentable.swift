//
//  MoviesViewRepresentable.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 11/03/24.
//

import SwiftUI

struct MoviesViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        //    MoviesViewController.buildFavorites()
        MoviesViewController.buildMovies()
    }
}

struct CarsViewPreviews: PreviewProvider{
    static var previews: some View {
        return MoviesViewRepresentable()
    }
}


