//
//  AuthenticationManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import Foundation

struct AuthenticationManager: Codable {
    var email: String
    var isLoggedIn: Bool
    var rememberme: Bool
}

