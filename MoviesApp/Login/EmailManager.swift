//
//  EmailManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 3/03/24.
//


import Foundation

struct EmailManager {
    static let shared = EmailManager()
    
    private let emailKey = "userEmail"
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    private init() {}
    
    func isValidEmail(email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func saveEmailLocally(email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: emailKey)
    }
    
    func getEmailLocally() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: emailKey)
    }
    
    
}
