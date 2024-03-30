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
        
        if UserManager.shared.retrieveUserDetails() != nil {
            if let rememberedUser = UserManager.shared.retrieveUserDetails()?.email {
                registerView?.textFieldEmail.text = rememberedUser
            }
        }
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
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "RememberMe")
    }
    
    func loginViewDidTapLoginButtonWith(_ registerView: RegisterView, credential: String, andRememberme rememberme: Bool) {
        UserManager.shared.loginUser(rememberMe: rememberme, userEmail: credential, nickname: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        self.registerView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        print("Keyboard disappeared")
        print(info)
        self.registerView?.keyboardDisappear(info)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func switchValueChanged(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "RememberMe")
    }
    
    func buttonCreateAccount(_ sender: UIButton) {
        guard let registerView = registerView else {
            showAlert(title: "Error", message: "An error occurred. Please try again.")
            return
        }
        
        guard let credential = registerView.getCredentialText(), !credential.isEmpty else {
            showAlert(title: "Error", message: "Please enter your email or nickname.")
            return
        }
        
        if !isValidEmail(credential) && !isValidNickname(credential) {
            showAlert(title: "Error", message: "Please enter a valid email or nickname.")
            return
        }
        
        let rememberMe = registerView.swithToRememberme.isOn
        
        self.delegate?.loginViewDidTapLoginButtonWith(registerView, credential: credential, andRememberme: rememberMe)
        
        self.navigationController?.popViewController(animated: true)
    }

    // Implementa la lógica de validación del nickname aquí
    private func isValidNickname(_ nickname: String) -> Bool {
        // Agrega tu lógica de validación del nickname aquí.
        return true
    }
}
