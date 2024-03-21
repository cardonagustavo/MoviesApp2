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
    
    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status == errSecDuplicateItem {
            // El elemento ya existe, así que lo actualizamos.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            // Actualizar elemento existente
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            return result as? Data
        } else {
            return nil
        }
    }
    
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        // Eliminar elemento del llavero
        SecItemDelete(query)
    }
}

extension KeyChainManager {
    func save<T>(_ item: T, service: String, account: String) where T: Codable {
        do {
            // Codificar como datos JSON y guardar en el llavero
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            assertionFailure("Error al codificar el elemento para el llavero: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable {
        // Leer datos del elemento del llavero
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decodificar datos JSON a objeto
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Error al decodificar el elemento del llavero: \(error)")
            return nil
        }
    }
}
