//
//  KeyChainManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation

final class KeyChainManager {
    static let standard = KeyChainManager()
    private init() {}
    
    enum KeyChainError: Error {
        case saveError(OSStatus)
        case readError(OSStatus)
        case deleteError(OSStatus)
    }
    
    func save(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess || status == errSecDuplicateItem else {
            throw KeyChainError.saveError(status)
        }
    }
    
    func read(service: String, account: String) throws -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil
            } else {
                throw KeyChainError.readError(status)
            }
        }
        
        return result as? Data
    }
    
    func delete(service: String, account: String) throws {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeyChainError.deleteError(status)
        }
    }
}
