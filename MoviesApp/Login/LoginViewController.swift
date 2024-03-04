//  LoginViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

//MARK: - Controller
class LoginViewController: UIViewController {
    private var loginView: LoginView? { self.view as? LoginView }
      
      var loginCustom: LoginViewProtocol? {
          self.view as? LoginViewProtocol
      }
      
      lazy var keyboardManager = KeyboardManager(delegate: self)
      
      override func viewDidLoad() {
          super.viewDidLoad()
          loginView?.textFieldLoginUpdate()
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
      
  //    override func viewWillDisappear(_ animated: Bool) {
  //        super.viewWillDisappear(animated)
  //        self.unregisterKeyboardNotifications()
  //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    

}

//MARK: - Extension
extension LoginViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
        print("teclado aparece")
               print(info)
               self.loginView?.keyboardAppear(info)
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        print("teclado desaparece")
                print(info)
                self.loginView?.keyboardDisappear(info)
    }
    
    
}

//MARK: - Login View Delegade
extension LoginViewController: LoginViewDelegade {
 /*   func tapButtonLoginShowRegisterView(_ loginView: LoginView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        else {
            return
        }
        self.show(controller, sender: self)
    }
    */
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else { return }
        self.show(controller, sender: self)
//        controller.modalTransitionStyle = .coverVertical
//        self.present(controller, animated: true)
    }
}
