//
//  ShortLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//
import Foundation
import UIKit

/// Estrategia de inicio de sesión rápido.
class ShortLoginStrategy: LoginStrategy {
    
    /// Referencia débil al controlador de vista que iniciará sesión.
    weak var viewController: UIViewController?

    /// Inicializador de la estrategia de inicio de sesión rápida.
    /// - Parameter viewController: El controlador de vista desde el cual se inicia sesión.
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler) {
        // Implementación de inicio de sesión...

        // Luego del inicio de sesión exitoso:
        completionLoginHandler()
        // Por ejemplo, si quieres navegar a otra pantalla después del inicio de sesión:
        viewController?.performSegue(withIdentifier: "TabBarNavigationController", sender: nil)
    }
}





