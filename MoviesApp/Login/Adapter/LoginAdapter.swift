//
//  LoginAdapter.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class LoginAdapter {
    func loginUserWithUserEmail(_ userEmail: String, andRememberme rememberme: Bool) {
        UserManager.shared.loginUser(rememberMe: rememberme, userEmail: userEmail, nickname: nil)
    }
}
