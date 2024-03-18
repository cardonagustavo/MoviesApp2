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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    
    private func customTabBarr() {
        
        let movies = MoviesViewController.buildMovies()
        let favorites = MoviesViewController.buildFavorites()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        movies.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "square.split.2x2.fill"), tag: 0)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        movies.navigationItem.title = "Movies"
        favorites.navigationItem.title = "Favorites"
        
       viewControllers = [movies, favorites, movies, favorites]
        
        if let originalImage = UIImage(named: "logout.png") {
            let targetSize = CGSize(width: 30, height: 30)
            
            UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let scaledImage = scaledImage {
                let buttonShortLogin = UIButton(type: .custom)
                buttonShortLogin.setImage(scaledImage, for: .normal)
                
                buttonShortLogin.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
                
                let customBarButtonItem = UIBarButtonItem(customView: buttonShortLogin)
                
                self.navigationItem.rightBarButtonItem = customBarButtonItem
            } else {
                print("Error: No se pudo escalar la imagen")
            }
        } else {
            print("Error: No se pudo cargar la imagen 'logout.png'")
        }

    
     }
    
    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }

    
    @objc private func logoutUser() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        SessionManager.standard.logoutWithRememberme()
        
        if SessionManager.standard.isUserRequestedRememberLogin() {
            let shortLoginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
            self.show(shortLoginViewController, sender: self)
        } else {
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ShortLoginViewController") as! ShortLoginViewController
            self.show(loginViewController, sender: self)
        }
    }

}

