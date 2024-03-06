//  LoginView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

@objc protocol LoginViewDelegade: AnyObject {
//    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView)
   // func tapButtonLoginShowRegisterView(_ loginView: LoginView)
}

// MARK: - Protocolos
protocol LoginViewProtocol {
    func textFieldLoginUpdate()
    func setupNavigationBarAppearance()
}

//MARK: - Class
class LoginView: UIView {

    @IBOutlet weak var delegate: LoginViewDelegade?
    
   // @IBOutlet private weak var delegade: LoginViewProtocolDelegade?
    @IBAction private func tapToCloseKeyboard(_gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    
    @IBAction func buttonRegister(_ sender: UIButton) {
     //   self.delegate?.tapButtonLoginShowRegisterView(self)
    }
    
    @IBAction func buttonTapLogin(_ sender: UIButton) {
//        self.delegate?.tapButtonLoginShowToMoviesCell(self)
        

    }
//    
    @IBOutlet private weak var groupViewKeyboardView: UIView!
    @IBOutlet private weak var groupViewKeyboardAnchorCenterAxisY: NSLayoutConstraint!
    
    
//    @IBAction func textFieldDidChanged(_ sender: UITextField) {
//        delegate?.textViewDidChange(sender.text ?? "")
//    }
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
//        self.groupViewKeyboard.frame.origin.y + self.groupViewKeyboard.frame.height
        
    }
    
    func keyboardDisappear(_ info: KeyboardManager.Info) {
        UIView.animate(withDuration: info.animationDuration) {
            self.groupViewKeyboardAnchorCenterAxisY.constant = 0
            self.layoutIfNeeded()
        }
        
    }
    
//    func textFieldDidChangedMethod(_ text: String) {
//        
//    }
    
    
    func textFieldLoginUpdate() {
        self.textFieldLogin.font = UIFont(name: "veradna", size: 30)
        self.textFieldLogin.placeholder = "E-mail or Number Phone"
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
