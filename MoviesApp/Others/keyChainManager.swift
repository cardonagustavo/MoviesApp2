//
//  KeyChainManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 20/03/24.
//

import Foundation

/// `KeyChainManager` es una clase singleton que proporciona métodos para guardar, leer y eliminar datos del llavero del sistema.
final class KeyChainManager {
    
    /// Singleton estándar para el administrador de llaveros.
    static let standard = KeyChainManager()
    
    /// Constructor privado para mantener el singleton.
    private init() {}
    
    /// Enumeración que representa los posibles errores que pueden ocurrir durante las operaciones del llavero.
    enum KeyChainError: Error {
        /// Error al guardar los datos en el llavero.
        case saveError(OSStatus)
        /// Error al leer los datos del llavero.
        case readError(OSStatus)
        /// Error al eliminar los datos del llavero.
        case deleteError(OSStatus)
    }
    
    /// Guarda los datos en el llavero para un servicio y una cuenta específicos.
    /// - Parameters:
    ///   - data: Los datos que se guardarán en el llavero.
    ///   - service: El nombre del servicio asociado a los datos.
    ///   - account: El nombre de la cuenta asociada a los datos.
    /// - Throws: `KeyChainError.saveError` si ocurre un error al guardar los datos.
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
    
    /// Lee los datos del llavero para un servicio y una cuenta específicos.
    /// - Parameters:
    ///   - service: El nombre del servicio asociado a los datos.
    ///   - account: El nombre de la cuenta asociada a los datos.
    /// - Returns: Los datos leídos del llavero o `nil` si no se encuentran.
    /// - Throws: `KeyChainError.readError` si ocurre un error al leer los datos.
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
    
    /// Elimina los datos del llavero para un servicio y una cuenta específicos.
    /// - Parameters:
    ///   - service: El nombre del servicio asociado a los datos.
    ///   - account: El nombre de la cuenta asociada a los datos.
    /// - Throws: `KeyChainError.deleteError` si ocurre un error al eliminar los datos.
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
