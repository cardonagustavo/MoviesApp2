//
//  shortLoginViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.


import UIKit

// MARK: - ShortLoginViewController

class ShortLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var loginView: LoginViewProtocol? { self.view as? LoginViewProtocol }
    var loginStrategy: LoginStrategy!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginStrategy()
    }
    
    // MARK: - Private Methods
    
    /// Configura la estrategia de inicio de sesión corto.
    private func setupLoginStrategy() {
        loginStrategy = ShortLoginStrategy(viewController: self)
    }
}
