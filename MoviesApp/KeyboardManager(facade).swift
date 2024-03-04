//  KeyboardManager(facade).swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 5/02/24.

import Foundation
import UIKit

protocol KeyboardManagerDelegate:  AnyObject {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info)
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info)

}
class KeyboardManager {
    private unowned var delegate: KeyboardManagerDelegate
    
    init(delegate: KeyboardManagerDelegate) {
        self.delegate = delegate
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWilHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        //             NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        print("El teclado aparece")
        let info = KeyboardManager.Info(userInfo: notification.userInfo)
        self.delegate.keyboardManager(self, keyboardWillShowWith: info)

        print(notification.userInfo ?? "Sin datos")
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        print("""
                 frame: \(keyboardFrame)
                 duration: \(animationDuration)
                 """)
    }
    
    @objc private func keyboardWilHide(_ notification: Notification) {
        print("El teclado se va")
        let info = KeyboardManager.Info(userInfo: notification.userInfo)
        self.delegate.keyboardManager(self, keyboardWillHideWith: info)

        print(notification.userInfo ?? "Sin datos")
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        print("""
                 frame: \(keyboardFrame)
                 duration: \(animationDuration)
                 """)
        
    }
}


extension KeyboardManager {
    
    struct Info {
        let frame: CGRect
        let animationDuration: Double
        
        fileprivate init(userInfo: [AnyHashable: Any]?) {
            self.frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            self.animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        }
    }
}
