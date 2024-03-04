//  RegisterViewController.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.

import UIKit

class RegisterViewController: UIViewController {
    
    private var registerView: RegisterView? { self.view as? RegisterView }
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView?.customComponentsLabel()
        registerView?.customComponentsTextField()
//        registerView?.setupTransparentBackgroundViews()
        registerView?.updateButtonCreate()
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


extension RegisterViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info) {
//        print("Teclado aparece")
        self.registerView?.keyboardAppear(info)
    }
    
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info) {
        print("Teclado desaparece")
        print(info)
        self.registerView?.keyboardDisappear(info)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func loginViewTapButtonRegister(_ registerView: RegisterView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.dismiss(animated: true)
        print("Here")
        self.navigationController?.popViewController(animated: true)
//        guard let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
//        else {
//            return
//        }
//        self.show(controller, sender: self)
//        controller.modalTransitionStyle = .coverVertical
//        self.present(controller, animated: true)
    }
}

