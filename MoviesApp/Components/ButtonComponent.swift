//
//  ButtonComponent.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/04/24.
//
import UIKit

/// Clase personalizada para un botón con diseño sofisticado.
class ButtonComponent: UIButton {
    
    // MARK: - Properties
    
    /// Capa de gradiente para el fondo del botón.
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // MARK: - Private Methods
    
    /// Configura el aspecto del botón.
    private func setupButton() {
        // Color de fondo negro
        self.backgroundColor = UIColor.black
        
        // Configuración del gradiente dorado
        gradientLayer.colors = [
            UIColor.black.cgColor, // Negro en ambos extremos para el fondo
            UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor, // Dorado intenso
            UIColor.black.cgColor // Negro en ambos extremos para el fondo
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [-1.0, -0.5, 0.0]
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Estilo del texto y borde dorado
        setTitleColor(UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0), for: .normal)
        titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
        clipsToBounds = true
        
        // Configuración de la sombra
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Animation
    
    /// Animación del gradiente para desplazarse de izquierda a derecha.
    func animateGradient() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 2.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "gradientShift")
    }
    
    // MARK: - Highlighted State
    
    override var isHighlighted: Bool {
        didSet {
            let transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            UIView.animate(withDuration: 0.1) {
                self.transform = transform
            }
        }
    }
}
