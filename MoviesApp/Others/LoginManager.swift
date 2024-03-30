//
//  LoginManager.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 30/03/24.
//

import Foundation

class LoginManager {
    private var loginStrategy: LoginStrategy?
    
    func loginUser(withCredential credential: String, rememberme: Bool) {
        // Asumiendo que tienes una manera de obtener el objeto UserTest actual
        // Esto podría ser a través de una llamada al UserManager o a una base de datos
        if let userDetails = UserManager.shared.retrieveUserDetails() {
            // Verifica tanto el correo electrónico como el nickname
            if userDetails.email == credential || userDetails.nickname == credential {
                // El usuario ha ingresado un correo electrónico o nickname válido, procede con el inicio de sesión
                loginStrategy = ShortLoginStrategy()
                loginStrategy?.login(rememberme: rememberme, userEmail: userDetails.email, completionLoginHandler: {
                    // Manejar el éxito del inicio de sesión
                    print("Inicio de sesión exitoso")
                }, completionLoginErrorHandler: {
                    // Manejar el error del inicio de sesión
                    print("Error en el inicio de sesión")
                })
            } else {
                // El credential no coincide con el correo electrónico ni con el nickname, maneja el error
                print("Credencial inválida")
            }
        } else {
            // No se encontraron detalles del usuario, es posible que el usuario necesite registrarse
            print("Detalles del usuario no encontrados")
        }
    }
    
    func imprimirDatosDeUsuarioGuardados() {
        if let detallesDeUsuario = UserManager.shared.retrieveUserDetails() {
            print("Detalles de usuario guardados: \(detallesDeUsuario)")
        } else {
            print("No se encontraron detalles de usuario guardados.")
        }
    }
}
