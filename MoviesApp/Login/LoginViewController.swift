//  LoginViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

// MARK: - Controller
class LoginViewController: UIViewController {
    private var loginView: LoginView? { self.view as? LoginView }
    
    var loginCustom: LoginViewProtocol? {
        self.view as? LoginViewProtocol
    }
    
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.textFieldLoginUpdate()
        loginView?.updateLabels()
        loginView?.setupNavigationBarAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardManager.registerKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboardManager.unregisterKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
}

// MARK: - Extension
extension LoginViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        self.loginView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        self.loginView?.keyboardDisappear(info)
    }
}

// MARK: - Login View Delegate
extension LoginViewController: LoginViewDelegade {
    func buttonShortLogin(_ loginView: LoginView) {
        // Handle short login button tap if needed
    }
}
