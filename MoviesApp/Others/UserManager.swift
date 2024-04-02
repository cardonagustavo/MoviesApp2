//
//  UserManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.


import Foundation
import UIKit

struct UserManager {
    static let shared = UserManager()
    
    // Agrega el nuevo método 'registerUser'.
    func registerUser(email: String, nickname: String?, rememberMe: Bool) {
        let safeNickname = nickname ?? ""
        
        // Verificar si ya se debe registrar al usuario.
        guard shouldRegister(email: email, nickname: safeNickname) else {
            print(StringsLocalizable.Messages.checkIfTheUserIsRegistered.localized())
            return
        }
        
        // Crear un objeto UserTest con los datos del usuario.
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
    
    func logoutUser() {
        if isUserLoggedIn() {
            // Si el usuario está registrado, lo redirige al short login
            redirectToShortLogin()
        } else {
            // Si el usuario no está registrado, lo redirige al login completo
            redirectToFullLogin()
        }
    }
    
    // Método para verificar si el usuario está actualmente registrado (logueado).
    private func isUserLoggedIn() -> Bool {
        // Verifica si existen detalles de usuario en el Keychain.
        return retrieveUserDetails() != nil
    }
    
    // Método para redirigir al short login.
    private func redirectToShortLogin() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print(StringsLocalizable.Messages.AppDelegateError.localized())
                return
            }
            
            // Por ejemplo, si el short login está representado por un controlador de vista llamado ShortLoginViewController:
            let shortLoginViewController = ShortLoginViewController()
            appDelegate.window?.rootViewController = shortLoginViewController
        }
        
        // Método para redirigir al login completo.
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
    
    // Método para verificar si debemos registrar al usuario.
     func shouldRegister(email: String, nickname: String) -> Bool {
        return !isUserRegistered(withCredential: email) && !isUserRegistered(withCredential: nickname)
    }
    
    // Método para verificar si el usuario ya está registrado.
     func isUserRegistered(withCredential credential: String) -> Bool {
        if let userDetails = retrieveUserDetails() {
            return userDetails.email == credential || userDetails.nickname == credential
        } else {
            return false
        }
    }
    
    // Método para recuperar los detalles del usuario.
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
    
    // Método para cerrar la sesión del usuario (log out).
    func loginUser(withCredential credential: String, rememberme: Bool)  {
        do {
            try KeyChainManager.standard.delete(service: "com.yourapp.service", account: "userAccount")
        } catch {
            print("Error al cerrar la sesión del usuario: \(error)")
        }
    }
}
