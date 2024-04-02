//
//  LoadingWait.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 2/04/24.
//

import UIKit

class CustomLoaderView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let animationDuration: CFTimeInterval = 1.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoader()
    }
    
    private func setupLoader() {
        let loaderSize = min(frame.size.width, frame.size.height)
        let loaderCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // Configurar gradiente
        gradientLayer.colors = [UIColor(red: 92/255, green: 94/255, blue: 220/255, alpha: 1).cgColor,
                                UIColor(red: 145/255, green: 71/255, blue: 255/255, alpha: 1).cgColor,
                                UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: loaderSize, height: loaderSize)
        layer.addSublayer(gradientLayer)
        
        // Configurar animaciones de rotación
        let rotateAnimation1 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation1.fromValue = 0
        rotateAnimation1.toValue = CGFloat.pi * 2
        rotateAnimation1.duration = animationDuration
        rotateAnimation1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        rotateAnimation1.repeatCount = .greatestFiniteMagnitude
        gradientLayer.add(rotateAnimation1, forKey: "rotateAnimation1")
        
        let rotateAnimation2 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation2.fromValue = 0
        rotateAnimation2.toValue = CGFloat.pi * 2
        rotateAnimation2.duration = animationDuration
        rotateAnimation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        rotateAnimation2.repeatCount = .greatestFiniteMagnitude
        gradientLayer.add(rotateAnimation2, forKey: "rotateAnimation2")
        
        let rotateAnimation3 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation3.fromValue = 0
        rotateAnimation3.toValue = CGFloat.pi * 2
        rotateAnimation3.duration = animationDuration
        rotateAnimation3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        rotateAnimation3.repeatCount = .greatestFiniteMagnitude
        gradientLayer.add(rotateAnimation3, forKey: "rotateAnimation3")
        
        let animationDelay: CFTimeInterval = 0.1
        
        rotateAnimation1.beginTime = CACurrentMediaTime() + animationDelay
        rotateAnimation2.beginTime = CACurrentMediaTime() + animationDelay
        rotateAnimation3.beginTime = CACurrentMediaTime() + animationDelay
        
        // Configurar máscara para crear el círculo
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: loaderSize, height: loaderSize)).cgPath
        gradientLayer.mask = maskLayer
    }
}
