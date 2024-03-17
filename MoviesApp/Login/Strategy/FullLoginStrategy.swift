//
//  FullLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class FullLoginStrategy: LoginStrategy {
    let email = "emailTest@test.com"
    var loginAdapter: LoginAdapter = LoginAdapter()

    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler) {
        if !userEmail.isEmpty && userEmail == self.email {
            self.loginAdapter.loginUserWithUserEmail(userEmail, andRememberme: rememberme)
            completionLoginHandler()
        } else {
            completionLoginErrorHandler()
        }
    }
}
