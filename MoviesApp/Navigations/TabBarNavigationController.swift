//
//  TabBarNavigationController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 12/03/24.
//

import UIKit

class TabBarNavigationController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBarr()
        updateNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    
    private func customTabBarr() {
        
        let movies = MoviesViewController.buildMovies()
        let favorites = MoviesViewController.buildFavorites()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        movies.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "square.split.2x2.fill"), tag: 0)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        
       viewControllers = [movies, favorites]
        
        let logoutProfile = UIImage(systemName: "person.circle.fill")
        let logoutProfileButton = UIBarButtonItem(image: logoutProfile, style: .plain, target: self, action: #selector())
        self.navigationItem.rightBarButtonItem = [logoutProfile]
    
     }
    
    func updateNavigationBar() {
        let customButtonBack = UIBarButtonItem()
        navigationItem.leftBarButtonItems = [customButtonBack]
    }
    
    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
//    @objc private func logoutUser() {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        UserSessionHelper.standard.logoutWithRememberme()
//        
//        if UserSessionHelper.standard.isUserRequestedRememberLogin() {
//            let shortLoginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
//            self.navigationController?.present(shortLoginViewController, animated: true)
//        } else {
//            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.navigationController?.present(loginViewController, animated: true)
//        }
//    }
}
/*
 
 private func addControllers() {
     let moviesList = MoviesViewController.buildMoviesList()
     let favoritesList = MoviesViewController.buildFavoritesList()
     
     moviesList.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
     favoritesList.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))

     self.viewControllers = [moviesList, favoritesList]
     
     let logoutImage = UIImage(systemName: "person.fill.badge.minus")
     let logoutButton = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(logoutUser))
     self.navigationItem.rightBarButtonItems = [logoutButton]
 }
 
 @objc private func logoutUser() {
     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     UserSessionHelper.standard.logoutWithRememberme()
     
     if UserSessionHelper.standard.isUserRequestedRememberLogin() {
         let shortLoginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
         self.navigationController?.present(shortLoginViewController, animated: true)
     } else {
         let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
         self.navigationController?.present(loginViewController, animated: true)
     }
 }
}
 */
