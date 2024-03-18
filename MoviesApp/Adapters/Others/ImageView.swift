//
//  ImageView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 17/03/24.
//

import UIKit
import Alamofire

extension UIImageView {
    typealias CompletionHandler = (_ image: UIImage?, _ urlImage: String) -> Void

    func downloadImage(_ url: String, withAnimation: Bool = true, completion: CompletionHandler? = nil) {
        if withAnimation {
            showAnimationPlaceholder()
        }
        
        AF.request(url).responseData { response in
            guard let data = response.data else {
                if let completion = completion {
                    completion(nil, url)
                }

                return
            }
            
            let image = UIImage(data: data)
            
            if let completion = completion {
                completion(image, url)
            }
        }
    }
        
    private func showAnimationPlaceholder() {
        self.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
        }, completion: nil)
    }
    
    func animateAndSetImage(_ image: UIImage?) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.image = image
            self.backgroundColor = .clear
        }, completion: nil)
    }
}

