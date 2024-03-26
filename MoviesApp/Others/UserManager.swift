//
//  UserManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//
import Foundation

// MARK: - Class Definition
class UserSessionManager {
    static let standard = SessionManager()
    
    func isLoggedIn() -> Bool {
        return self.getUser().isLoggedIn
    }
    
    func isUserRequestedRememberLogin() -> Bool {
        return self.getUser().rememberme
    }
    
    func login(rememberme: Bool, userEmail: String) {
        KeyChainManager.standard.save(UserTest(email: userEmail, isLoggedIn: true, rememberme: rememberme), service: "userTest", account: "user")
    }
    
    func logoutWithRememberme() {
        KeyChainManager.standard.save(self.logout(), service: "userTest, account: ", account: "user")
    }
    
    func logout() -> UserTest {
        var user = self.getUser()
        user.isLoggedIn = false
        return user
    }
    
    func logoutAndDisableRememberme() {
        var userToLogout = self.logout()
        userToLogout.rememberme = false
        userToLogout.email = ""
        
            KeyChainManager.standard.save(userToLogout, service: "userTest", account: "user")
    }
    
    func getUser() -> UserTest {
        guard let UserUser = KeyChainManager.standard.read(service: "userTest", account: "user", type: UserTest.self) else { return UserTest(email: "", isLoggedIn: false, rememberme: false) }
        return UserUser
    }
    
    func isRegisteredUserByEmail(_ email: String) -> Bool {
        self.getUsersRegistered().filter { $0.email == email }.count > 0
    }
    
    func getUsersRegistered() -> [UserTest] {
        guard let usersRegistered = KeyChainManager.standard.read(service: "userTest", account: "usersRegistered", type: [UserTest].self) else { return [] }
        return usersRegistered
    }
    
    func retrieveFavoritesByUserLogged() -> [Favorite] {
        let user = self.getUser()
        if !user.email.isEmpty {
            return KeyChainManager.standard.read(service: "userTest", account: "favorites-\(user.email)", type: [Favorite].self) ?? []
        } else {
            return []
        }
    }
    
    // Whit this line, we prevent that we can't create a new instance of this class
    private init() {}
}
