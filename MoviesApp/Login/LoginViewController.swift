//  LoginViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

class LoginViewController: UIViewController {
    
    private var hasPerformedSegue: Bool = false
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
        loginView?.buttonsUpdate()
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
extension LoginViewController: LoginViewDelegade {
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView) {
            guard !hasPerformedSegue else {
                return
            }
            
            // Obtén el correo electrónico o nickname del campo de texto de la vista de login
            if let inputText = loginView.getEmailOrNickname(), !inputText.isEmpty {
                // Verifica si la credencial es válida con UserManager
                if UserManager.shared.isValidCredential(inputText) {
                    // Aquí el usuario existe y puedes proceder con el flujo normal de inicio de sesión
                    let loginStrategy = ShortLoginStrategy()
                    loginStrategy.login(rememberme: true, userEmail: inputText) {
                        self.performSegue(withIdentifier: "TabBarNavigationController", sender: nil)
                        self.hasPerformedSegue = true
                    } completionLoginErrorHandler: {
                        // Manejar el error de inicio de sesión aquí
                        print("Error en el inicio de sesión")
                    }
                } else {
                    // El usuario no está registrado, muestra la alerta personalizada
                    showAlertToRegister()
                }
            } else {
                // El campo está vacío, muestra una alerta indicando que se necesita llenar el campo de texto
                showAlertForEmptyField()
            }
        }
        
        // Método para mostrar una alerta cuando el campo de texto está vacío.
        private func showAlertForEmptyField() {
            let alert = UIAlertController(
                title: "Campo Vacío",
                message: "Por favor, ingrese su correo electrónico o nickname para iniciar sesión.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    
    private func showAlertToRegister() {
            let alert = UIAlertController(
                title: "No estás registrado",
                message: "Aún no estás registrado, te invitamos a realizar tu registro.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Registrar", style: .default) { _ in
                // Aquí puedes manejar el flujo para llevar al usuario a la pantalla de registro.
                // Por ejemplo, si tienes un segue definido hacia el registro:
                self.performSegue(withIdentifier: "RegisterViewController", sender: nil)
            })
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    
    
//    func tapButtonLoginShowRegisterView(_ loginView: LoginView) {
//        self.performSegue(withIdentifier: "RegisterViewController", sender: nil)
//    }
    
    func buttonShortLogin(_ loginView: LoginView) {
        // Handle short login button tap if needed
    }
}

