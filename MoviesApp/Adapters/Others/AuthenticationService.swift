//
//  AuthenticationService.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation

class AuthenticationService {
    static let shared = AuthenticationService()

    func performFullLogin(username: String, password: String, completion: (Bool) -> Void) {
        // Implementación de full login
    }

    func performShortLogin(completion: (Bool) -> Void) {
        // Implementación de short login utilizando credenciales de Keychain
    }
}
