//
//  FullLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import Foundation

/// Estrategia de inicio de sesión completa.
class FullLoginStrategy: LoginStrategy {
    
    /// Inicia sesión con la estrategia completa.
    /// - Parameters:
    ///   - rememberme: Un booleano que indica si se debe recordar el inicio de sesión.
    ///   - userEmail: El correo electrónico del usuario para iniciar sesión.
    ///   - completionLoginHandler: El cierre que se llama cuando el inicio de sesión es exitoso.
    ///   - completionLoginErrorHandler: El cierre que se llama cuando hay un error durante el inicio de sesión.
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler) {
   
        completionLoginHandler()
    }
}

