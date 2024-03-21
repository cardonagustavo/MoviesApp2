//
//  SessionManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation


class SessionManager {
    static let shared = SessionManager()

    var isAuthenticated: Bool
    var currentUser: UserTest?

    init() {
        // Inicializa las propiedades aquí
        self.isAuthenticated = false
        // currentUser es opcional, por lo que puede ser nil por defecto
    }
}
