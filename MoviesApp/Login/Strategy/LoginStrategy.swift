//
//  LoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import Foundation

protocol LoginStrategy {
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: @escaping CompletionLoginHandler, completionLoginErrorHandler: @escaping CompletionLoginErrorHandler)
}

// MARK: - Closures
extension LoginStrategy {
    typealias CompletionLoginHandler = () -> Void
    typealias CompletionLoginErrorHandler = () -> Void
}

