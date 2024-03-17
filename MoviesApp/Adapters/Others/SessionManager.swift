//
//  SessionManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//
import Foundation

// MARK: - Class Definition
class SessionManager {
    static let standard = SessionManager()
    
    func isLoggedIn() -> Bool {
        return self.authenticationUserObtained().isLoggedIn
    }
    
    func isUserRequestedRememberLogin() -> Bool {
        return self.authenticationUserObtained().rememberme
    }
    
    func login(rememberme: Bool, userEmail: String) {
        keyChangeManager.standard.save(AuthenticationManager(email: userEmail, isLoggedIn: true, rememberme: rememberme), service: "userTest.com", account: "user")
    }
    
    func logoutWithRememberme() {
        keyChangeManager.standard.save(self.logout(), service: "userTest.com", account: "user")
    }
    
    func logout() -> AuthenticationManager {
        var user = self.authenticationUserObtained()
        user.isLoggedIn = false
        
        return user
    }
    
    func logoutAndDisableRememberme() {
        var userToLogout = self.logout()
        userToLogout.rememberme = false
        userToLogout.email = ""
        
        keyChangeManager.standard.save(userToLogout, service: "userTest.com", account: "user")
    }
    
    func authenticationUserObtained() -> AuthenticationManager {
        guard let authenticationUserObtained = keyChangeManager.standard.read(service: "userTest.com", account: "user", type: AuthenticationManager.self) else { return AuthenticationManager(email: "", isLoggedIn: false, rememberme: false) }
        return authenticationUserObtained
    }
    
    
    // Whit this line, we prevent that we can't create a new instance of this class
    private init() {}
}
