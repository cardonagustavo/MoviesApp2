//
//  UserTest.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation


// MARK: - User Definition
struct UserTest: Codable {
    var email: String
    var isLoggedIn: Bool
    var rememberme: Bool
}
