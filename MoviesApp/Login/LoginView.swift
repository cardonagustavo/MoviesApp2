//  LoginView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

@objc protocol LoginViewDelegate: AnyObject {
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView)
//    func tapButtonLoginShowRegisterView(_ loginView: LoginView)
    func buttonShortLogin(_ loginView: LoginView)
}

// MARK: - Protocolos
protocol LoginViewProtocol {
    func textFieldLoginUpdate()
    func setupNavigationBarAppearance()
    func updateLabels()
    func buttonsUpdate()
   
}

//MARK: - Class
class LoginView: UIView {

    @IBOutlet weak var delegate: LoginViewDelegate?
    
    // @IBOutlet private weak var delegade: LoginViewProtocolDelegade?
    @IBAction private func tapToCloseKeyboard(_gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelCreateAccount: UILabel!
    @IBOutlet weak var buttonRegister: UIButton!
        
    @IBAction func buttonRegister(_ sender: UIButton) {
//        self.delegate?.tapButtonLoginShowRegisterView(self)
    }
    @IBAction func buttonTapLogin(_ sender: UIButton) {
        self.delegate?.tapButtonLoginShowToMoviesCell(self)
        
    }
    
    @IBOutlet private weak var groupViewKeyboardView: UIView!
    @IBOutlet private weak var groupViewKeyboardAnchorCenterAxisY: NSLayoutConstraint!
    @IBOutlet weak var labelShortLogin: UILabel!
    @IBOutlet weak var buttonShortLoginOutlet: UIButton!
    @IBAction func buttonShortLogin(_ sender: Any) {
        self.delegate?.buttonShortLogin(self)
    }
}

// MARK: - Extencion
extension LoginView: LoginViewProtocol {
    func setupNavigationBarAppearance() {
        let font = UIFont(name: "FONT NAME", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
    }
    
    func keyboardAppear(_ info: KeyboardManager.Info) {
        if info.frame.origin.y < self.groupViewKeyboardView.frame.maxY {
            let delta = info.frame.origin.y -  self.groupViewKeyboardView.frame.maxY
            
            UIView.animate(withDuration: info.animationDuration) {
                self.groupViewKeyboardAnchorCenterAxisY.constant = delta
                self.layoutIfNeeded()
                print(delta)
            }
        }
    }
    
    func keyboardDisappear(_ info: KeyboardManager.Info) {
        UIView.animate(withDuration: info.animationDuration) {
            self.groupViewKeyboardAnchorCenterAxisY.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func updateLabels() {
        self.labelCreateAccount.font = UIFont(name: "veradna", size: 30)
        self.labelCreateAccount.textColor = UIColor.principalInvertBackground
        self.labelCreateAccount.layer.cornerRadius = 20.0
        self.labelCreateAccount.text = StringsLocalizable.LoginView.labelCreateAccount.localized()
        
    }
    
    func buttonsUpdate() {
        self.buttonLogin.setTitle(StringsLocalizable.LoginView.buttonLogin.localized(), for: .normal)
        self.buttonRegister.setTitle(StringsLocalizable.LoginView.buttonRegister.localized(), for: .normal)
    }

    func getEmailOrNickname() -> String? {
            return textFieldLogin.text
        }

    
    func textFieldLoginUpdate() {
        self.textFieldLogin.font = UIFont(name: "veradna", size: 30)
        self.textFieldLogin.placeholder = StringsLocalizable.LoginView.textFieldLogin.localized()
        self.textFieldLogin.textColor = UIColor.principalInvertBackground
        self.textFieldLogin.layer.cornerRadius = 20.0
        
    }
    
    class YourAppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            setupNavigationBarAppearance()
            return true
        }
        func setupNavigationBarAppearance() {
            let font = UIFont(name: "FONT NAME", size: 18) ?? UIFont.systemFont(ofSize: 18)
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.white
            ]
            
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().clipsToBounds = false
            UINavigationBar.appearance().backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
            UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        }
    }
    
}
