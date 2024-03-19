//
//  keyChainManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.
//


import Foundation

/// Clase para administrar el almacenamiento y recuperación de datos en el llavero del sistema.
/// Basado en: https://swiftsenpai.com/development/persist-data-using-keychain/
class KeychainManager {
    
    /// Instancia estática compartida de `KeychainManager`.
    static let standard = KeychainManager()
    
    /// Método privado para evitar la creación de instancias adicionales de `KeychainManager`.
    private init() {}
    
    /// Guarda un elemento genérico codificable en el llavero del sistema.
    ///
    /// - Parameters:
    ///   - item: Elemento a guardar en el llavero.
    ///   - service: Nombre del servicio asociado al elemento.
    ///   - account: Nombre de la cuenta asociada al elemento.
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        do {
            // Codifica el elemento como datos JSON y lo guarda en el llavero
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            assertionFailure("Error al codificar el elemento para el llavero: \(error)")
        }
    }
    
    /// Guarda datos en el llavero del sistema.
    ///
    /// - Parameters:
    ///   - data: Datos a guardar en el llavero.
    ///   - service: Nombre del servicio asociado a los datos.
    ///   - account: Nombre de la cuenta asociada a los datos.
    private func save(_ data: Data, service: String, account: String) {
        // Crea la consulta para el llavero
        let query = [kSecValueData: data, kSecClass: kSecClassGenericPassword, kSecAttrService: service, kSecAttrAccount: account] as CFDictionary
        
        // Agrega los datos a la consulta en el llavero
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            // Imprime el error si ocurre
            print("Error: \(status)")
        }

        if status == errSecDuplicateItem {
            // Si el elemento ya existe, lo actualiza.
            let query = [kSecAttrService: service, kSecAttrAccount: account, kSecClass: kSecClassGenericPassword] as CFDictionary
            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            // Actualiza el elemento existente
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    /// Lee un elemento genérico decodificable del llavero del sistema.
    ///
    /// - Parameters:
    ///   - service: Nombre del servicio asociado al elemento.
    ///   - account: Nombre de la cuenta asociada al elemento.
    ///   - type: Tipo del elemento a decodificar.
    /// - Returns: El elemento decodificado del llavero, o nil si no se puede leer o decodificar.
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable {
        // Lee los datos del elemento del llavero
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decodifica los datos JSON en un objeto
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Error al decodificar el elemento del llavero: \(error)")
            return nil
        }
    }
    
    /// Lee datos del llavero del sistema.
    ///
    /// - Parameters:
    ///   - service: Nombre del servicio asociado a los datos.
    ///   - account: Nombre de la cuenta asociada a los datos.
    /// - Returns: Los datos leídos del llavero, o nil si no se pueden leer.
    private func read(service: String, account: String) -> Data? {
        let query = [kSecAttrService: service, kSecAttrAccount: account, kSecClass: kSecClassGenericPassword, kSecReturnData: true] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }

    /// Elimina un elemento del llavero del sistema.
    ///
    /// - Parameters:
    ///   - service: Nombre del servicio asociado al elemento a eliminar.
    ///   - account: Nombre de la cuenta asociada al elemento a eliminar.
    func delete(service: String, account: String) {
        let query = [kSecAttrService: service, kSecAttrAccount: account, kSecClass: kSecClassGenericPassword] as CFDictionary
        
        // Elimina el elemento del llavero
        SecItemDelete(query)
    }
}
