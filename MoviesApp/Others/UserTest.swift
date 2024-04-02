//
//  UserTest.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation

/// Representa la estructura de un usuario de prueba.
struct UserTest: Codable {
    /// Correo electrónico del usuario.
    let email: String
    
    /// Apodo del usuario.
    let nickname: String
    
    /// Indica si el usuario está actualmente logueado.
    let isLoggedIn: Bool
    
    /// Indica si se debe recordar al usuario.
    let rememberMe: Bool
    
    /// Usuario recordado.
    let rememberedUser: String
}


