//
//  SessionManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//
import Foundation

// MARK: - Class Definition
/**
 Gestiona la sesión de usuario, incluida la autenticación, el inicio de sesión, el cierre de sesión y la gestión de favoritos.
 */
class SessionManager {
    /// Propiedad estática que proporciona una instancia única de SessionManager utilizando el patrón Singleton.
    static let standard = SessionManager()
    
    /**
     Comprueba si el usuario está actualmente autenticado.
     
     - Returns: Un valor booleano que indica si el usuario está autenticado.
     */
    func isLoggedIn() -> Bool {
        return self.authenticationUserObtained().isLoggedIn
    }
    
    /**
     Comprueba si el usuario ha solicitado recordar su inicio de sesión.
     
     - Returns: Un valor booleano que indica si el usuario ha solicitado recordar su inicio de sesión.
     */
    func isUserRequestedRememberLogin() -> Bool {
        return self.authenticationUserObtained().rememberme
    }
    
    /**
     Inicia sesión en la aplicación con la opción de recordar el inicio de sesión.
     
     - Parameters:
     - rememberme: Un booleano que indica si se debe recordar el inicio de sesión.
     - userEmail: La dirección de correo electrónico del usuario que inicia sesión.
     */
    func login(rememberme: Bool, userEmail: String) {
        KeychainManager.standard.save(AuthenticationManager(email: userEmail, isLoggedIn: true, rememberme: rememberme), service: "userTest", account: "user")
    }
    
    /**
     Cierra la sesión del usuario y deshabilita la opción de recordar el inicio de sesión.
     */
    func logoutWithRememberme() {
        KeychainManager.standard.save(self.logout(), service: "userTest", account: "user")
    }
    
    /**
     Cierra la sesión del usuario.
     
     - Returns: Un objeto AuthenticationManager que representa al usuario con la sesión cerrada.
     */
    func logout() -> AuthenticationManager {
        var user = self.authenticationUserObtained()
        user.isLoggedIn = false
        
        return user
    }
    
    /**
     Comprueba si un usuario está registrado en la aplicación mediante su dirección de correo electrónico.
     
     - Parameter email: La dirección de correo electrónico del usuario a comprobar.
     - Returns: Un valor booleano que indica si el usuario está registrado.
     */
    func isRegisteredUserByEmail(_ email: String) -> Bool {
        self.getUsersRegistered().filter { $0.email == email }.count > 0
    }
    
    /**
     Obtiene todos los usuarios registrados en la aplicación.
     
     - Returns: Un array de AuthenticationManager que contiene todos los usuarios registrados.
     */
    func getUsersRegistered() -> [AuthenticationManager] {
        guard let usersRegistered = KeychainManager.standard.read(service: "userTest", account: "usersRegistered", type: [AuthenticationManager].self) else { return [] }
        return usersRegistered
    }
    
    /**
     Cierra la sesión del usuario y deshabilita la opción de recordar el inicio de sesión.
     */
    func logoutAndDisableRememberme() {
        var userToLogout = self.logout()
        userToLogout.rememberme = false
        userToLogout.email = ""
        
        KeychainManager.standard.save(userToLogout, service: "userTest", account: "user")
    }
    
    /**
     Obtiene la información de autenticación del usuario actualmente autenticado.
     
     - Returns: Un objeto AuthenticationManager que representa la información de autenticación del usuario.
     */
    func authenticationUserObtained() -> AuthenticationManager {
        guard let authenticationUserObtained = KeychainManager.standard.read(service: "userTest", account: "user", type: AuthenticationManager.self) else { return AuthenticationManager(email: "", isLoggedIn: false, rememberme: false) }
        return authenticationUserObtained
    }
    
    /**
     Obtiene los favoritos del usuario actualmente autenticado.
     
     - Returns: Un array de Favorite que contiene los favoritos del usuario.
     */
    func retrieveFavoritesByUserLogged() -> [Favorite] {
        let user = self.authenticationUserObtained()
        if !user.email.isEmpty {
            return KeychainManager.standard.read(service: "userTest", account: "favorites-\(user.email)", type: [Favorite].self) ?? []
        } else {
            return []
        }
    }
    
    /**
     Constructor privado que evita la creación de nuevas instancias de esta clase.
     */
    private init() {}
}
