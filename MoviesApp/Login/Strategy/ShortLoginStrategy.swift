//
//  ShortLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class ShortLoginStrategy: LoginStrategy {
    var loginAdapter: LoginAdapter = LoginAdapter()
    
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler) {
        self.loginAdapter.loginUserWithUserEmail(userEmail, andRememberme: rememberme)
        completionLoginHandler()
    }
}

