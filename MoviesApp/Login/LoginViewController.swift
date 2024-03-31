//  LoginViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

class LoginViewController: UIViewController {
    
    private var hasPerformedSegue: Bool = false
    private var loginView: LoginView? { self.view as? LoginView }
    
    let loginManager = LoginManager()
    
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.textFieldLoginUpdate()
        loginView?.updateLabels()
        loginView?.setupNavigationBarAppearance()
        imprimirDatosDeUsuarioGuardados()
        loginView?.buttonsUpdate()
    }
    
    func imprimirDatosDeUsuarioGuardados() {
        if let detallesDeUsuario = UserManager.shared.retrieveUserDetails() {
            print("Detalles de usuario guardados:")
            print("Email: \(detallesDeUsuario.email)")
            print("Nickname: \(detallesDeUsuario.nickname)")
            print("IsLoggedIn: \(detallesDeUsuario.isLoggedIn)")
            print("RememberMe: \(detallesDeUsuario.rememberMe)")
            print("RememberedUser: \(String(describing: detallesDeUsuario.rememberedUser))")
        } else {
            print("No se encontraron detalles de usuario guardados.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardManager.registerKeyboardNotifications()
        self.hasPerformedSegue = false
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

// MARK: - KeyboardManagerDelegate
extension LoginViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        self.loginView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        self.loginView?.keyboardDisappear(info)
    }
}

// MARK: - LoginViewDelegade
extension LoginViewController: LoginViewDelegate {
    
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView) {
           guard !hasPerformedSegue else {
               return
           }
           if let inputText = loginView.getEmailOrNickname(), !inputText.isEmpty {
               if UserManager.shared.isUserRegistered(withCredential: inputText) {
                   // El usuario está registrado, ahora intenta iniciar sesión
                   loginManager.loginUser(withCredential: inputText, rememberMe: true)
               } else {
                   showAlertForRegistrationRequired(from: self)
               }
           } else {
               showAlertForEmptyField(from: self)
           }
       }
    
    func buttonShortLogin(_ loginView: LoginView) {
    }
    
    private func showAlertForEmptyField(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Login Error",
            message: "Por favor, ingrese su correo electrónico o nickname valido para iniciar sesión.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    private func showAlertForRegistrationRequired(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: "No estás registrado",
            message: "Aún no estás registrado, te invitamos a realizar tu registro.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Registrar", style: .default) { _ in
            viewController.performSegue(withIdentifier: "RegisterViewController", sender: nil)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
    
}
