//
//  ShortLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//
import Foundation
import UIKit

class ShortLoginStrategy: LoginStrategy {
    weak var viewController: UIViewController?

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




