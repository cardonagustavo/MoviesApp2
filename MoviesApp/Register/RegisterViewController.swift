//  RegisterViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.
import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    func loginViewDidTapLoginButtonWith(_ registerView: RegisterView, credential: String, andRememberme rememberme: Bool)
}

class RegisterViewController: UIViewController {
    
    private var registerView: RegisterView? { self.view as? RegisterView }
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    weak var delegate: RegisterViewControllerDelegate?
    
    private let remembermeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView?.customComponentsLabel()
        registerView?.customComponentsTextField()
        registerView?.updateButtonCreate()
        registerView?.delegate = self
        
        let isRemembering = UserDefaults.standard.bool(forKey: "RememberMe")
        registerView?.configureSwitch(isOn: isRemembering)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardManager.registerKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboardManager.unregisterKeyboardNotifications()
    }
}

// MARK: - KeyboardManagerDelegate

extension RegisterViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        self.registerView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        self.registerView?.keyboardDisappear(info)
    }
}

// MARK: - RegisterViewDelegate

extension RegisterViewController: RegisterViewDelegate {
    func switchValueChanged(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "RememberMe")
    }
    
    func buttonCreateAccount(_ sender: UIButton) {
            guard let registerView = registerView else {
                showAlert(title: "Error", message: StringsLocalizable.Messages.ErrorOccurred.localized())
                return
            }
            
            guard let email = registerView.textFieldEmail.text, !email.isEmpty else {
                showAlert(title: "Error", message: StringsLocalizable.Messages.EnterEmail.localized())
                return
            }
            
            guard isValidEmail(email) else {
                showAlert(title: "Error", message: StringsLocalizable.Messages.EnterValidEmail.localized())
                return
            }
            
            guard let nickname = registerView.textFieldNickName.text, !nickname.isEmpty else {
                showAlert(title: "Error", message: StringsLocalizable.Messages.EnterNickname.localized())
                return
            }
            
            let rememberMe = registerView.swithToRememberme.isOn
            
            // Verificar si el correo o el apodo ya están registrados
            if UserManager.shared.isUserRegistered(withCredential: email) || UserManager.shared.isUserRegistered(withCredential: nickname) {
                showAlert(title: "Error", message: StringsLocalizable.Messages.EmailNicknameIsRegistered.localized())
                return
            }
            
            // Llama al método 'registerUser' en UserManager.
            UserManager.shared.registerUser(email: email, nickname: nickname, rememberMe: rememberMe)
            
            // Si el correo y el apodo son válidos y no están registrados, navegar al login.
            delegate?.loginViewDidTapLoginButtonWith(registerView, credential: email, andRememberme: rememberMe)
            navigationController?.popViewController(animated: true)
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }

    private func isValidNickname(_ nickname: String) -> Bool {
        // Supongamos que tenemos alguna lógica para validar el apodo aquí.
        // Por ahora, solo devolvemos true para hacer que el código sea compilable.
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
