//
//  UserTest.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation


struct UserTest: Codable {
    var email: String
    var nickname: String
    var isLoggedIn: Bool
    var rememberMe: Bool
    var rememberedUser: String?
}

