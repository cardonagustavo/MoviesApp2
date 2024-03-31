//
//  StarsRank.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 14/03/24.
//

import UIKit

/// Clase personalizada para mostrar un rango de estrellas con una barra de progreso.
class StarsRank: UIView {
    
    // MARK: - Properties
    
    /// Barra de progreso utilizada para mostrar el progreso del rango de estrellas.
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        progressView.progressTintColor = .orange
        progressView.trackTintColor = UIColor(white: 0, alpha: 0)
        return progressView
    }()
    
    // MARK: - Initialization
    
    /// Inicializador requerido cuando se instancia la vista programáticamente.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMask()
        setupProgressView()
    }
    
    /// Inicializador requerido cuando se instancia la vista desde un archivo de interfaz.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMask()
        setupProgressView()
    }
    
    // MARK: - Private Methods
    
    /// Configura y agrega la barra de progreso a la vista.
    private func setupProgressView() {
        addSubview(progressView)
        
        // Establece las restricciones para la barra de progreso
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// Configura la máscara de la vista para dibujar un rango de estrellas.
    private func setupMask() {
        /// Calcula las dimensiones de una estrella en base al tamaño de la vista
        let starWidth = bounds.width / 10
        let starHeight = bounds.height / 10
        
        /// Crea una capa de forma para la máscara
        let maskLayer = CAShapeLayer()
        
        for i in 0..<10 {
            let xOffset = CGFloat(i) * starWidth
            let starPath = UIBezierPath()
            
            /// Define el camino de una estrella dentro de la máscara
            starPath.move(to: CGPoint(x: xOffset + 0.5 * starWidth, y: 0))
            starPath.addLine(to: CGPoint(x: xOffset + 0.65 * starWidth, y: 0.35 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + starWidth, y: 0.4 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.75 * starWidth, y: 0.65 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.8 * starWidth, y: starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.5 * starWidth, y: 0.85 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.2 * starWidth, y: starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.25 * starWidth, y: 0.65 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0, y: 0.4 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.35 * starWidth, y: 0.35 * starHeight))
            starPath.close()
            
            /// Crea una capa de borde para cada estrella y la agrega a la vista
            let customBorderLayer = CAShapeLayer()
            customBorderLayer.path = starPath.cgPath
            customBorderLayer.fillColor = nil
            customBorderLayer.strokeColor = UIColor(named: "PrincipalInvertBackground")?.cgColor // Color personalizado para la línea
            customBorderLayer.lineWidth = 1.0
            customBorderLayer.frame = bounds
            layer.insertSublayer(customBorderLayer, at: 0)
            
            /// Crea una capa de forma para cada estrella y la agrega a la máscara
            let starMaskLayer = CAShapeLayer()
            starMaskLayer.path = starPath.cgPath
            starMaskLayer.fillColor = UIColor.orange.cgColor
            maskLayer.insertSublayer(starMaskLayer, at: 0) // Insertar detrás de las capas de borde
            
            /// Aplica un sombreado a la estrella para un efecto tridimensional
            starMaskLayer.shadowColor = UIColor.darkGray.cgColor
            starMaskLayer.shadowOffset = CGSize(width: 0, height: 1)
            starMaskLayer.shadowOpacity = 0.5
            starMaskLayer.shadowRadius = 2
            
            /// Aplica la máscara a la vista
            layer.mask = maskLayer
        }
    }
}

