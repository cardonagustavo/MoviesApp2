//
//  UserManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.


import Foundation

class UserManager {
    static let shared = UserManager()
    
    func registerUser(email: String, nickname: String?) {
        let safeNickname = nickname ?? ""
        let userInfo = UserTest(email: email, nickname: safeNickname, isLoggedIn: true, rememberMe: true, rememberedUser: email)
        KeyChainManager.standard.save(userInfo, service: "com.yourapp.service", account: "userAccount")
    }
    
    func loginUser(rememberMe: Bool, userEmail: String, nickname: String?) {
        let safeNickname = nickname ?? ""
        if rememberMe {
            let userInfo = UserTest(email: userEmail, nickname: safeNickname, isLoggedIn: true, rememberMe: rememberMe, rememberedUser: userEmail)
            KeyChainManager.standard.save(userInfo, service: "com.yourapp.service", account: "userAccount")
        } else {
            // Aquí deberías llamar al método logoutUser de la clase UserManager
            self.logoutUser()
        }
    }
    func isUserRegistered() -> Bool {
        // Aquí implementa la lógica para verificar si el usuario está registrado.
        // Por ejemplo, puedes comprobar si existe alguna información de usuario en el Keychain.
        // Si el usuario está registrado, devuelve true, de lo contrario, devuelve false.
        return retrieveUserDetails() != nil
    }

    
    func isValidCredential(_ credential: String) -> Bool {
        // Aquí implementa la lógica para verificar si el credential es válido.
        // Por ejemplo, podrías comprobar si el credential está en tu base de datos de usuarios.
        // Si el credential es válido, devuelve true, de lo contrario, devuelve false.
        return true // Aquí devuelves true temporalmente, deberás implementar la lógica real.
    }
    
    func retrieveUserDetails() -> UserTest? {
        return KeyChainManager.standard.read(service: "com.yourapp.service", account: "userAccount", type: UserTest.self)
    }
    
    func logoutUser() {
        // Elimina la información del usuario de Keychain al cerrar la sesión
        KeyChainManager.standard.delete(service: "com.yourapp.service", account: "userAccount")
    }
}
