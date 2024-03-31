//
//  LoginManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 30/03/24.
//
import Foundation
import UIKit


class LoginManager {
    weak var viewController: UIViewController?
    
    func loginUser(withCredential credential: String, rememberMe: Bool) {
        if let userDetails = UserManager.shared.retrieveUserDetails() {
            if userDetails.email == credential || userDetails.nickname == credential {
                guard let viewController = self.viewController else {
                    print("Error: No se puede realizar la transición porque la vista controladora es nula.")
                    return
                }
                let loginStrategy = ShortLoginStrategy(viewController: viewController)
                
                // He cambiado `completionLoginErrorHandler` para que no tome ningún argumento.
                loginStrategy.login(rememberme: rememberMe, userEmail: userDetails.email, completionLoginHandler: {
                    [weak viewController] in
                    guard let viewController = viewController else {
                        print("Error: No se puede realizar la transición porque la vista controladora es nula.")
                        return
                    }
                    viewController.performSegue(withIdentifier: "TabBarNavigationController", sender: nil)
                }, completionLoginErrorHandler: { // Se han eliminado los argumentos de esta clausura.
                    // Como no tenemos el error, se muestra un mensaje genérico.
                    guard self.viewController != nil else { return }
                    // Manejar el caso de error aquí, tal vez mostrando una alerta con un mensaje genérico
                    print("Se produjo un error durante el inicio de sesión.")
                })
            } else {
                print("Credencial inválida")
            }
        } else {
            print("Detalles del usuario no encontrados")
        }
    }
}

