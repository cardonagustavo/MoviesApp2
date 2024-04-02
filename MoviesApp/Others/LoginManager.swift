//
//  LoginManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 30/03/24.
//
import Foundation
import UIKit


/// Clase que gestiona el inicio de sesión del usuario.
struct LoginManager {
    /// Referencia débil a la vista controladora para evitar retención circular.
    weak var viewController: UIViewController?
    
    /// Método para iniciar sesión del usuario.
    ///
    /// - Parameters:
    ///   - credential: La credencial del usuario (email o apodo).
    ///   - rememberMe: Booleano que indica si se debe recordar el inicio de sesión.
    ///
    /// Este método permite que un usuario inicie sesión en la aplicación proporcionando una credencial (correo electrónico o apodo) y una indicación sobre si se debe recordar el inicio de sesión o no. Utiliza los detalles del usuario recuperados de `UserManager` para verificar las credenciales proporcionadas por el usuario. Si las credenciales son válidas, utiliza una estrategia de inicio de sesión específica, como `ShortLoginStrategy`, para realizar el proceso de inicio de sesión y manejar los casos de éxito y error.
    func loginUser(withCredential credential: String, rememberMe: Bool) {
        // Verificar si se pueden obtener los detalles del usuario
        if let userDetails = UserManager.shared.retrieveUserDetails() {
            // Verificar si la credencial coincide con el email o el apodo del usuario
            if userDetails.email == credential || userDetails.nickname == credential {
                // Verificar si la vista controladora está disponible
                guard let viewController = self.viewController else {
                    print("Error: No se puede realizar la transición porque la vista controladora es nula.")
                    return
                }
                // Crear una estrategia de inicio de sesión
                let loginStrategy = ShortLoginStrategy(viewController: viewController)
                
                // Iniciar sesión utilizando la estrategia de inicio de sesión corto
                loginStrategy.login(rememberme: rememberMe, userEmail: userDetails.email) {
                    // Éxito en el inicio de sesión: realizar la transición a la pantalla principal
                    [weak viewController] in
                    guard let viewController = viewController else {
                        print("Error: No se puede realizar la transición porque la vista controladora es nula.")
                        return
                    }
                    viewController.performSegue(withIdentifier: "TabBarNavigationController", sender: nil)
                } completionLoginErrorHandler: {
                    // Error en el inicio de sesión: manejar el error
                    // Como no tenemos el error, se muestra un mensaje genérico.
                    guard self.viewController != nil else { return }
                    // Manejar el caso de error aquí, tal vez mostrando una alerta con un mensaje genérico
                    print("Se produjo un error durante el inicio de sesión.")
                }
            } else {
                print("Credencial inválida")
            }
        } else {
            print("Detalles del usuario no encontrados")
        }
    }
}
