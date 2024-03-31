//
//  TabBarNavigationController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 12/03/24.
//
import UIKit

class TabBarNavigationController: UITabBarController {
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        customTabBar()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupNavigationBar()
        setupTabBar()
        setupCustomBackground()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    private func setupTabBar() {
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
        
        if let logoutImage = UIImage(named: "logout.png")?.scaled(toSize: CGSize(width: 30, height: 30)) {
            let buttonLogout = UIButton(type: .custom)
            buttonLogout.setImage(logoutImage, for: .normal)
            buttonLogout.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
            
            let customBarButtonItem = UIBarButtonItem(customView: buttonLogout)
            
            self.navigationItem.rightBarButtonItem = customBarButtonItem
        } else {
            print("Error: No se pudo cargar la imagen 'logout.png'")
        }
    }
    
    private func setupCustomBackground() {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = determineBackgroundColor()
        
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
    
    // MARK: - Actions
    
    @objc private func redirectToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        UserManager.shared.logoutUser()
        redirectToLogin()
    }

    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}

extension UIImage {
    func scaled(toSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
