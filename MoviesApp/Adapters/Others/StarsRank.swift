//
//  StarsRank.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 14/03/24.
//

import UIKit

class StarsRank: UIView {
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .yellow
        progressView.progress = 0.0
        progressView.progressTintColor = .yellow
        progressView.trackTintColor = UIColor(white: 0, alpha: 0)
        
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMask()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMask()
        setupProgressView()
    }
    
    private func setupProgressView() {
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupMask() {
        let starWidth = bounds.width / 10
        let starHeight = bounds.height / 10

        let maskLayer = CAShapeLayer()
        for i in 0..<10 {
            let xOffset = CGFloat(i) * starWidth
            let starPath = UIBezierPath()
            
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
            
            let starMaskLayer = CAShapeLayer()
            starMaskLayer.path = starPath.cgPath
            starMaskLayer.fillColor = UIColor.yellow.cgColor // Color del fondo
            maskLayer.addSublayer(starMaskLayer)
            
            let borderLayer = CAShapeLayer()
            borderLayer.path = starPath.cgPath
            borderLayer.fillColor = nil
            borderLayer.strokeColor = UIColor.yellow.cgColor
            borderLayer.lineWidth = 1.0
            borderLayer.frame = bounds
            layer.insertSublayer(borderLayer, at: 0)
        }
        
        layer.mask = maskLayer
    }
}

