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
        customTabBar()
        setupCustomBackground()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    
    private func customTabBar() {
        
        let movies = MoviesViewController.buildMovies()
        let favorites = MoviesViewController.buildFavorites()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        movies.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "square.split.2x2.fill"), tag: 0)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        
        viewControllers = [movies, favorites]
        
        if let originalImage = UIImage(named: "logout.png") {
            let targetSize = CGSize(width: 30, height: 30)
            
            UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let scaledImage = scaledImage {
                let buttonShortLogin = UIButton(type: .custom)
                buttonShortLogin.setImage(scaledImage, for: .normal)
                
                
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
    
    private func setupCustomBackground() {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = determineBackgroundColor()
        
        // Ajusta el fondo de la vista del tab bar controller
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.addSubview(customBackgroundView)
        tabBar.sendSubviewToBack(customBackgroundView)
        
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: tabBar.topAnchor),
            customBackgroundView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
    }
    
    private func determineBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(named: "DarkModeBackgroundColor") ?? .black
            } else {
                return UIColor(named: "LightModeBackgroundColor") ?? .white
            }
        } else {
            return UIColor(named: "FallbackBackgroundColor") ?? .white
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Actualiza el color de fondo cuando cambie el modo de color del sistema
        guard UITraitCollection.current.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
            return
        }
        tabBar.subviews.first?.backgroundColor = determineBackgroundColor()
    }
    
}
