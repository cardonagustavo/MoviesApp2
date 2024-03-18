//
//  SessionManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//
import Foundation

/// Manages user sessions and authentication.
class SessionManager {
    /// The singleton instance of `SessionManager`.
    static let standard = SessionManager()
    
    /// Checks if a user is currently logged in.
    ///
    /// - Returns: A boolean value indicating the login status.
    func isLoggedIn() -> Bool {
        return self.authenticationUserObtained().isLoggedIn
    }
    
    /// Checks if the user requested to be remembered at login.
    ///
    /// - Returns: A boolean value indicating the remember login status.
    func isUserRequestedRememberLogin() -> Bool {
        return self.authenticationUserObtained().rememberme
    }
    
    /// Logs in the user with the specified parameters.
    ///
    /// - Parameters:
    ///   - rememberme: A boolean value indicating whether to remember the login.
    ///   - userEmail: The email address of the user.
    func login(rememberme: Bool, userEmail: String) {
        keyChangeManager.standard.save(AuthenticationManager(email: userEmail, isLoggedIn: true, rememberme: rememberme), service: "userTest", account: "user")
    }
    
    /// Logs out the user while maintaining the remember login status.
    func logoutWithRememberme() {
        keyChangeManager.standard.save(self.logout(), service: "userTest", account: "user")
    }
    
    /// Logs out the user and returns the updated user information.
    ///
    /// - Returns: The updated `AuthenticationManager` after logout.
    func logout() -> AuthenticationManager {
        var user = self.authenticationUserObtained()
        user.isLoggedIn = false
        
        return user
    }
    
    /// Checks if a user with the specified email address is registered.
    ///
    /// - Parameter email: The email address to check.
    /// - Returns: A boolean value indicating the registration status.
    func isRegisteredUserByEmail(_ email: String) -> Bool {
        self.getUsersRegistered().filter { $0.email == email }.count > 0
    }
    
    /// Retrieves a list of registered users.
    ///
    /// - Returns: An array of `AuthenticationManager` instances.
    func getUsersRegistered() -> [AuthenticationManager] {
        guard let usersRegistered = keyChangeManager.standard.read(service: "userTest", account: "usersRegistered", type: [AuthenticationManager].self) else { return [] }
        return usersRegistered
    }
    
    /// Logs out the user and disables remember login.
    func logoutAndDisableRememberme() {
        var userToLogout = self.logout()
        userToLogout.rememberme = false
        userToLogout.email = ""
        
        keyChangeManager.standard.save(userToLogout, service: "userTest", account: "user")
    }
    
    /// Retrieves the currently authenticated user information.
    ///
    /// - Returns: The `AuthenticationManager` representing the authenticated user.
    func authenticationUserObtained() -> AuthenticationManager {
        guard let authenticationUserObtained = keyChangeManager.standard.read(service: "userTest", account: "user", type: AuthenticationManager.self) else { return AuthenticationManager(email: "", isLoggedIn: false, rememberme: false) }
        return authenticationUserObtained
    }
    
    /// Retrieves favorites associated with the currently logged-in user.
    ///
    /// - Returns: An array of `Favorite` instances representing the user's favorites.
    func retrieveFavoritesByUserLogged() -> [Favorite] {
        let user = self.authenticationUserObtained()
        if !user.email.isEmpty {
            return keyChangeManager.standard.read(service: "userTest", account: "favorites-\(user.email)", type: [Favorite].self) ?? []
        } else {
            return []
        }
    }
    
    /// Prevents the creation of a new instance of `SessionManager`.
    private init() {}
}

