//
//  LoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import Foundation

/// Protocolo para definir estrategias de inicio de sesión.
protocol LoginStrategy {
    
    /// Método para iniciar sesión.
    /// - Parameters:
    ///   - rememberme: Indica si se debe recordar la sesión.
    ///   - userEmail: Correo electrónico del usuario.
    ///   - completionLoginHandler: Closure llamado cuando el inicio de sesión es exitoso.
    ///   - completionLoginErrorHandler: Closure llamado cuando hay un error en el inicio de sesión.
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler)
}

// MARK: - Closures

extension LoginStrategy {
    
    /// Closure llamado cuando el inicio de sesión es exitoso.
    typealias CompletionLoginHandler = () -> Void
    
    /// Closure llamado cuando hay un error en el inicio de sesión.
    typealias CompletionLoginErrorHandler = () -> Void
}

