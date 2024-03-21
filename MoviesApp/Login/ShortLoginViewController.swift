//
//  ShortLoginViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.


import UIKit


// MARK: - Short Login View Controller

class ShortLoginViewController: UIViewController {
    var loginView: LoginViewProtocol? { self.view as? LoginViewProtocol }
    var loginStrategy: LoginStrategy = ShortLoginStrategy()
    var authenticationManager = SessionManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        loginView?.textFieldLoginUpdate()
        loginView?.setupNavigationBarAppearance()
        loginView?.updateStyleButtonShortLogin()
        loginView?.updateLabels()
        
        // Set username in short login button
        if let email = authenticationManager.currentUser?.email {
            loginView?.shortLoginButtonEmail(email)
        }
    }
}

// MARK: - Delegates
extension ShortLoginViewController: LoginViewDelegade {
    func buttonShortLogin(_ loginView: LoginView) {
        // Implementar lógica para iniciar sesión corto
        if let email = authenticationManager.currentUser?.email {
            loginStrategy.login(rememberme: true, userEmail: email) {
                // Successful login
                self.performSegue(withIdentifier: "ShortLoguinViewController", sender: nil)
            } completionLoginErrorHandler: {
                // Handle login errors
                print("Error en el inicio de sesión corto")
            }
        }
    }
}
