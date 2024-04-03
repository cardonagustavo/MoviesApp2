//
//  TabBarNavigationController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 12/03/24.
//
import UIKit

// MARK: - Tab Bar Navigation Controller

/// Controlador de vista para la barra de pestañas de la aplicación.
class TabBarNavigationController: UITabBarController {
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            printNavigationStack()
        }
        
    private func printNavigationStack() {
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if let title = viewController.title {
                    print("Pila de navegación: \(title)")
                } else {
                    print("Pila de navegación: \(String(describing: type(of: viewController)))")
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Configura la interfaz de usuario.
    private func setupUI() {
        setupNavigationBar()
        setupTabBar()
        customTabBar()
        setupCustomBackground()
    }
    
    /// Configura la barra de navegación.
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    /// Configura la barra de pestañas.
    private func setupTabBar() {
        self.tabBar.shadowImage = UIImage()
        self.tabBar.tintColor = UIColor(red: 0.0, green: 0.4, blue: 1.0, alpha: 1.0)
    }
    
    /// Personaliza la barra de pestañas con títulos, elementos y un botón de cierre de sesión.
    private func customTabBar() {
        let moviesTitle = MoviesViewController.buildMovies()
        let favoritesTitle = MoviesViewController.buildFavorites()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        moviesTitle.tabBarItem = UITabBarItem(title: StringsLocalizable.ErrorView.moviesTitle.localized(), image: UIImage(systemName: "square.split.2x2.fill"), tag: 0)
        favoritesTitle.tabBarItem = UITabBarItem(title: StringsLocalizable.ErrorView.favoritesTitle.localized(), image: UIImage(systemName: "star.fill"), tag: 1)

        viewControllers = [moviesTitle, favoritesTitle]
        
        setupLogoutButton()
    }
    
    /// Configura el botón de cierre de sesión.
    private func setupLogoutButton() {
        guard let logoutImage = UIImage(named: "logout.png")?.scaled(toSize: CGSize(width: 30, height: 30)) else {
            print("Error: No se pudo cargar la imagen 'logout.png'")
            return
        }
        
        let buttonLogout = UIButton(type: .custom)
        buttonLogout.setImage(logoutImage, for: .normal)
        buttonLogout.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        let customBarButtonItem = UIBarButtonItem(customView: buttonLogout)
        self.navigationItem.rightBarButtonItem = customBarButtonItem
    }
    
    /// Configura el fondo personalizado de la barra de pestañas.
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
    
    /// Determina el color de fondo basado en el modo de interfaz.
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
    
    /// Maneja el evento del botón de cierre de sesión.
    @objc private func logoutButtonTapped() {
        // Busca el controlador de vista LoginViewController en la pila de navegación
        if let loginViewController = navigationController?.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController?.popToViewController(loginViewController, animated: true)
        } else {
            print("Error: No se encontró el controlador de vista LoginViewController en la pila de navegación.")
        }
    }
}

// MARK: - UIImage Extension

extension UIImage {
    /// Escala la imagen al nuevo tamaño especificado.
    func scaled(toSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
