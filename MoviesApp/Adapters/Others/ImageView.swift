//
//  ImageView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 17/03/24.
//
import UIKit
import Alamofire

extension UIImageView {
    
    /// Tipo de cierre utilizado para devolver una imagen descargada junto con su URL.
    typealias CompletionHandler = (_ image: UIImage?, _ urlImage: String) -> Void

    /// Descarga una imagen desde una URL y la muestra en la vista de imagen.
    ///
    /// - Parameters:
    ///   - url: La URL de la imagen a descargar.
    ///   - withAnimation: Un booleano que indica si se debe mostrar una animación de carga.
    ///   - completion: Un cierre que se llama cuando se completa la descarga, devolviendo la imagen descargada y su URL.
    func downloadImage(_ url: String, withAnimation: Bool = true, completion: CompletionHandler? = nil) {
        if withAnimation {
            showAnimationPlaceholder()
        }
        
        AF.request(url).responseData { response in
            guard let data = response.data else {
                // Si no hay datos de respuesta, llama al cierre de finalización con nil y la URL.
                if let completion = completion {
                    completion(nil, url)
                }
                return
            }
            
            let image = UIImage(data: data)
            
            // Llama al cierre de finalización con la imagen descargada y la URL.
            if let completion = completion {
                completion(image, url)
            }
        }
    }
        
    /// Muestra una animación de carga de imagen.
    private func showAnimationPlaceholder() {
        // Configura el color de fondo inicial.
        self.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        
        // Configura la animación de cambio de color de fondo.
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
        }, completion: nil)
    }
    
    /// Aplica una animación de fundido cruzado y establece la imagen en la vista de imagen.
    ///
    /// - Parameter image: La imagen que se va a establecer.
    func animateAndSetImage(_ image: UIImage?) {
        // Realiza una transición suave para cambiar la imagen y el color de fondo.
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.image = image
            self.backgroundColor = .clear
        }, completion: nil)
    }
}
