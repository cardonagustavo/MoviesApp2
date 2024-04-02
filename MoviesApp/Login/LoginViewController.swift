//  LoginViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

// MARK: - Clase del controlador de vista de inicio de sesión
class LoginViewController: UIViewController {
    
    // MARK: - Propiedades
    
    /// Bandera para controlar si se ha realizado una transición de vista.
    private var hasPerformedSegue: Bool = false
    
    /// Vista de inicio de sesión.
    private var loginView: LoginView? { self.view as? LoginView }
    
    /// Administrador de inicio de sesión.
    let loginManager = LoginManager()
    
    /// Administrador del teclado para manejar su aparición y desaparición.
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    // MARK: - Ciclo de vida de la vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        imprimirDatosDeUsuarioGuardados()
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
        // Ocultar los botones de navegación
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    // MARK: - Métodos privados
    
    /// Configura la interfaz de usuario.
    private func setupUI() {
        loginView?.textFieldLoginUpdate()
        loginView?.updateLabels()
        loginView?.setupNavigationBarAppearance()
        loginView?.buttonsUpdate()
    }
    
    /// Imprime los detalles de usuario guardados en la consola.
    private func imprimirDatosDeUsuarioGuardados() {
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
}


// MARK: - Extensión para conformidad con el protocolo KeyboardManagerDelegate
extension LoginViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        // Ajustar la posición de la vista cuando aparece el teclado
        self.loginView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        // Restaurar la posición de la vista cuando desaparece el teclado
        self.loginView?.keyboardDisappear(info)
    }
}

// MARK: - Extensión para conformidad con el protocolo LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    
    // MARK: - Métodos del delegado de la vista de inicio de sesión
    
    /// Método llamado al tocar el botón de inicio de sesión
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView) {
        // Verificar si ya se realizó una transición de vista
        guard !hasPerformedSegue else {
            return
        }
        
        // Obtener el texto ingresado en el campo de texto de inicio de sesión
        if let inputText = loginView.getEmailOrNickname(), !inputText.isEmpty {
            // Verificar si el usuario está registrado
            if UserManager.shared.isUserRegistered(withCredential: inputText) {
                // El usuario está registrado, intentar iniciar sesión
                loginManager.loginUser(withCredential: inputText, rememberMe: true)
            } else {
                // Mostrar una alerta indicando que se requiere registro
                showAlertForRegistrationRequired(from: self)
            }
        } else {
            // Mostrar una alerta indicando que el campo de texto está vacío
            showAlertForEmptyField(from: self)
        }
    }
    
    /// Método para manejar el inicio de sesión corto (no implementado)
    func buttonShortLogin(_ loginView: LoginView) {
        // No implementado actualmente
    }
    
    // MARK: - Métodos privados
    
    /// Muestra una alerta indicando que el campo de texto está vacío
    private func showAlertForEmptyField(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: StringsLocalizable.Messages.LoginErrorTitle.localized(),
            message: StringsLocalizable.Messages.LoginErrorMessage.localized(),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    /// Muestra una alerta indicando que se requiere registro
    private func showAlertForRegistrationRequired(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: StringsLocalizable.Messages.LoginErrorNeddRegisterTitle.localized(),
            message: StringsLocalizable.Messages.LoginErrorNeddRegisterMessage.localized(),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Registrar", style: .default) { _ in
            viewController.performSegue(withIdentifier: "RegisterViewController", sender: nil)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
}
