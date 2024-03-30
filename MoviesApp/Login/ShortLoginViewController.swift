//
//  ShortLoguinViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.


import UIKit

class ShortLoguinViewController: UIViewController {
    var loginView: LoginViewProtocol? { self.view as? LoginViewProtocol }
    var loginStrategy: LoginStrategy = ShortLoginStrategy()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        loginView?.textFieldLoginUpdate()
        loginView?.setupNavigationBarAppearance()
        loginView?.updateLabels()
        loginView?.buttonsUpdate()
    }
}

// MARK: - Delegates
extension ShortLoguinViewController: LoginViewDelegade {
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView) {
        // Implementación según sea necesario
    }
    
    func tapButtonLoginShowRegisterView(_ loginView: LoginView) {
        // Implementación según sea necesario
    }
    
    func buttonShortLogin(_ loginView: LoginView) {
//        // Obtener el usuario actual del UserManager
//        let currentUser = UserManager.getUser()
//
//        // Verificar si el usuario está autenticado
//        guard currentUser.isLoggedIn else {
//            print("Error: El usuario no está autenticado")
//            return
//        }
//        let email = currentUser.email
//
//        // Lógica para iniciar sesión corto
//        loginStrategy.login(rememberme: true, userEmail: email) {
//            // Inicio de sesión exitoso
//            self.performSegue(withIdentifier: "ShortLoguinViewController", sender: nil)
//        } completionLoginErrorHandler: {
//            // Manejar errores de inicio de sesión
//            print("Error en el inicio de sesión corto")
//        }
    }
}
