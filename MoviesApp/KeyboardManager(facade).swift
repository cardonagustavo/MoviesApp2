//  KeyboardManager(facade).swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 5/02/24.

import Foundation
import UIKit

/// Protocolo para delegar eventos relacionados con el teclado.
protocol KeyboardManagerDelegate: AnyObject {
    /// Se llama cuando el teclado está a punto de aparecer.
    ///
    /// - Parameters:
    ///   - keyboardManager: El administrador de teclado.
    ///   - info: Información sobre el teclado.
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillShowWith info: KeyboardManager.Info)
    
    /// Se llama cuando el teclado está a punto de desaparecer.
    ///
    /// - Parameters:
    ///   - keyboardManager: El administrador de teclado.
    ///   - info: Información sobre el teclado.
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboardWillHideWith info: KeyboardManager.Info)
}

/// Administrador de teclado para gestionar eventos relacionados con el teclado en la interfaz de usuario.
class KeyboardManager {
    /// Delegado para recibir eventos del administrador de teclado.
    private unowned var delegate: KeyboardManagerDelegate
    
    /// Inicializa el administrador de teclado con un delegado.
    ///
    /// - Parameter delegate: El delegado para recibir eventos de teclado.
    init(delegate: KeyboardManagerDelegate) {
        self.delegate = delegate
    }
    
    /// Registra las notificaciones del teclado.
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
    
    /// Anula el registro de las notificaciones del teclado.
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
    
    /// Método de notificación llamado cuando el teclado está a punto de aparecer.
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
    
    /// Método de notificación llamado cuando el teclado está a punto de desaparecer.
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

/// Extensión para `KeyboardManager` que contiene la estructura `Info`.
extension KeyboardManager {
    /// Estructura que contiene información sobre el teclado.
    struct Info {
        /// El marco del teclado en la pantalla.
        let frame: CGRect
        
        /// La duración de la animación del teclado.
        let animationDuration: Double
        
        /// Inicializa la estructura `Info` con la información proporcionada por las notificaciones del teclado.
        ///
        /// - Parameter userInfo: La información del usuario proporcionada por las notificaciones del teclado.
        fileprivate init(userInfo: [AnyHashable: Any]?) {
            self.frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            self.animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        }
    }
}
