//
//  FullLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class FullLoginStrategy: LoginStrategy {
    var loginAdapter: LoginAdapter = LoginAdapter()

    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler) {
        if !userEmail.isEmpty && (SessionManager.standard.isRegisteredUserByEmail(userEmail)) {
            self.loginAdapter.loginUserWithUserEmail(userEmail, andRememberme: rememberme)
            completionLoginHandler()
        } else {
            completionLoginErrorHandler()
        }
    }
}
