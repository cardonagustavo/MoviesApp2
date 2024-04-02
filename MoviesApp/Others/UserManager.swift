//
//  UserManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.


import Foundation
import UIKit


/// `UserManager` es una estructura que gestiona la autenticación y registro de usuarios en la aplicación. Proporciona métodos para registrar nuevos usuarios, verificar si un usuario está actualmente autenticado, cerrar sesión y recuperar información del usuario almacenada en el `Keychain`.
/// La estructura proporciona un singleton `shared` para acceder a la instancia única de `UserManager` en toda la aplicación.

struct UserManager {
    
    /// Singleton que proporciona una instancia compartida de UserManager.
    static let shared = UserManager()
    
    // MARK: - Registro de Usuario
    
    /// Registra un nuevo usuario en la aplicación.
    ///
    /// - Parameters:
    ///   - email: Correo electrónico del usuario.
    ///   - nickname: Apodo del usuario (opcional).
    ///   - rememberMe: Booleano que indica si se debe recordar al usuario.
    func registerUser(email: String, nickname: String?, rememberMe: Bool) {
        let safeNickname = nickname ?? ""
        
        // Verifica si el usuario ya está registrado.
        guard shouldRegister(email: email, nickname: safeNickname) else {
            print(StringsLocalizable.Messages.checkIfTheUserIsRegistered.localized())
            return
        }
        
        // Crea un objeto UserTest con los datos del usuario.
        let userInfo = UserTest(email: email, nickname: safeNickname, isLoggedIn: false, rememberMe: rememberMe, rememberedUser: email)

        // Intenta guardar los datos del usuario en el Keychain.
        do {
            let userData = try JSONEncoder().encode(userInfo)
            try KeyChainManager.standard.save(userData, service: "com.yourapp.service", account: "userAccount")
            print(StringsLocalizable.Messages.RegisteredUserSuccessfully.localized())
        } catch {
            print(StringsLocalizable.Messages.ErrorRegistering.localized() + "\(error)")
        }
    }
    
    // MARK: - Cierre de Sesión
    
    /// Cierra la sesión del usuario actual.
    func logoutUser() {
        if isUserLoggedIn() {
            redirectToShortLogin()
        } else {
            redirectToFullLogin()
        }
    }
    
    // MARK: - Métodos Privados
    
    /// Verifica si el usuario está actualmente logueado.
    private func isUserLoggedIn() -> Bool {
        // Verifica si existen detalles de usuario en el Keychain.
        return retrieveUserDetails() != nil
    }
    
    /// Redirige al short login.
    private func redirectToShortLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print(StringsLocalizable.Messages.AppDelegateError.localized())
            return
        }
        
        // Por ejemplo, si el short login está representado por un controlador de vista llamado ShortLoginViewController:
        let shortLoginViewController = ShortLoginViewController()
        appDelegate.window?.rootViewController = shortLoginViewController
    }
    
    /// Redirige al login completo.
    private func redirectToFullLogin() {
        // Por ejemplo, si estás utilizando la estrategia FullLoginStrategy para el inicio de sesión completo:
        let fullLoginStrategy = FullLoginStrategy()
        
        // Llama al método de inicio de sesión completo en la estrategia FullLoginStrategy
        fullLoginStrategy.login(rememberme: false, userEmail: "", completionLoginHandler: {
            // Aquí puedes realizar cualquier acción necesaria después del inicio de sesión completo
            // Por ejemplo, presentar una vista específica o actualizar la interfaz de usuario
            
            // Por ahora, simplemente imprime un mensaje
            print("Redireccionando al inicio de sesión completo...")
        }, completionLoginErrorHandler: {
            // Maneja cualquier error que pueda ocurrir durante el inicio de sesión completo
            print("Error durante el inicio de sesión completo.")
        })
    }
    
    /// Verifica si se debe registrar al usuario.
    private func shouldRegister(email: String, nickname: String) -> Bool {
        return !isUserRegistered(withCredential: email) && !isUserRegistered(withCredential: nickname)
    }
    
    /// Verifica si el usuario ya está registrado.
    func isUserRegistered(withCredential credential: String) -> Bool {
        if let userDetails = retrieveUserDetails() {
            return userDetails.email == credential || userDetails.nickname == credential
        } else {
            return false
        }
    }
    
    /// Recupera los detalles del usuario.
     func retrieveUserDetails() -> UserTest? {
        do {
            if let userData = try KeyChainManager.standard.read(service: "com.yourapp.service", account: "userAccount") {
                return try JSONDecoder().decode(UserTest.self, from: userData)
            } else {
                return nil
            }
        } catch {
            print("Error al recuperar los detalles del usuario: \(error)")
            return nil
        }
    }
    
    /// Cierra la sesión del usuario.
    ///
    /// - Parameters:
    ///   - credential: Credencial del usuario.
    ///   - rememberme: Booleano que indica si se debe recordar al usuario.
    func loginUser(withCredential credential: String, rememberme: Bool)  {
        do {
            try KeyChainManager.standard.delete(service: "com.yourapp.service", account: "userAccount")
        } catch {
            print("Error al cerrar la sesión del usuario: \(error)")
        }
    }
}
