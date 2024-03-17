//
//  ShortLoginViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//

import UIKit

class ShortLoginViewController: UIViewController {
    var loginView: LoginViewProtocol? { self.view as? LoginViewProtocol }
    var loginStrategy: LoginStrategy = ShortLoginStrategy()
    var AuthenticationManager = SessionManager.standard.authenticationUserObtained()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView?.updateStyleButtonShortLogin()
        self.loginView?.shortLoginButtonEmail(self.AuthenticationManager.email)
    }
}

// MARK: - Delegates
extension ShortLoginViewController: LoginViewDelegade {
    func buttonShortLogin(_ sender: Any) {
        self.loginStrategy.login(rememberme: true, userEmail: self.AuthenticationManager.email) {
            self.performSegue(withIdentifier: "MoviesTabBarNavigationController", sender: nil)
        } completionLoginErrorHandler: {}
    }
}
