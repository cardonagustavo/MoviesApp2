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
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.tabBar.shadowImage = UIImage()
        self.tabBar.tintColor = UIColor(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)




    }
    
    private func customTabBar() {
        let moviesTitle = MoviesViewController.buildMovies()
        let favoritesTitle = MoviesViewController.buildFavorites()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        moviesTitle.tabBarItem = UITabBarItem(title: StringsLocalizable.ErrorView.moviesTitle.localized(), image: UIImage(systemName: "square.split.2x2.fill"), tag: 0)
        favoritesTitle.tabBarItem = UITabBarItem(title: StringsLocalizable.ErrorView.favoritesTitle.localized(), image: UIImage(systemName: "star.fill"), tag: 1)


        
        viewControllers = [moviesTitle, favoritesTitle]
        
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
                return UIColor.systemBackground
            } else {
                return UIColor.systemBackground
            }
        } else {
            return UIColor.white
        }
    }
}
