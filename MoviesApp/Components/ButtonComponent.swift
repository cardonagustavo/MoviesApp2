//
//  ButtonComponent.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/04/24.
//
import UIKit

/// A custom class for a button with a sophisticated design.
class ButtonComponent: UIButton {
    
    // MARK: - Properties
    
    /// A gradient layer for the button's background.
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Initialization
    
    /// Initializes the button with a frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    /// Initializes the button from a storyboard or XIB file.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // MARK: - Private Methods
    
    /// Sets up the button's appearance.
    private func setupButton() {
        // Set the background color to black
        self.backgroundColor = UIColor.black
        
        // Configure the golden gradient background
        gradientLayer.colors = [
            UIColor.black.cgColor, // Black at both ends for the background
            UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor, // Intense gold color
            UIColor.black.cgColor // Black again at both ends for the background
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [-1.0, -0.5, 0.0]
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Text style and golden border
        setTitleColor(UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0), for: .normal)
        titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
        clipsToBounds = false
        
        // Shadow configuration
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }
    
    // MARK: - Layout
    
    /// Adjusts the gradient layer to the button's bounds when the layout changes.
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Animation
    
    /// An animation for the gradient to move from left to right.
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
    
    /// Changes the button's appearance when it is tapped.
    override var isHighlighted: Bool {
        didSet {
            let transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
            UIView.animate(withDuration: 0.1) {
                self.transform = transform
            }
        }
    }
}
