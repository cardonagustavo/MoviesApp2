//
//  ShortLoginStrategy.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class ShortLoginStrategy: LoginStrategy {
    var loginAdapter: LoginAdapter = LoginAdapter()
    func login(rememberme: Bool, userEmail: String, completionLoginHandler: () -> Void, completionLoginErrorHandler: () -> Void) {
        self.loginAdapter.loginUserWithUserEmail(userEmail, andRememberme: rememberme)
        // Aquí iría la lógica para iniciar sesión con el correo electrónico del usuario
        // Si el inicio de sesión es exitoso, llamas completionLoginHandler()
        // Si hay un error, llamas completionLoginErrorHandler()
    }
  
       
    }


