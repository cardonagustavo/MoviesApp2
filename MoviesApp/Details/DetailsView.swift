//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 28/02/24.
//

import UIKit

// MARK: - Delegate
@objc protocol DetailViewDelegate: AnyObject {
    
}

protocol DetailViewProtocol {
    func viewContainer()
    func imageDetailBackdrop(_ movies: MovieDetails)
    func imageDetail(_ movies: MovieDetails)
    func labelTitle(_ movies: MovieDetails)
    func labeldDate(_ movies: MovieDetails)
    func stackViewStars(_ movies: MovieDetails)
    func labelDescriptionTitle(_ movies: MovieDetails)
    func labelDescriptionText(_ movies: MovieDetails)
}

//MARK: - Class
class DetailView: UIView {
    
    
    
    @IBOutlet weak var viewContainerTop: UIView!
    
    
    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var stackViewStars: UIStackView!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelListGender: UILabel!
    @IBOutlet weak var labelDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescriptionText: UILabel!
}


extension DetailView {
//    func viewContainer() {
//      
//        self.layer.borderWidth = 2.0
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.cornerRadius = 10.0
//        
//      
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor,
//                                UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0).cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.cornerRadius = 10.0
//        gradientLayer.shadowOffset = CGSize(width: 0, height: 5)
//        gradientLayer.shadowColor = UIColor.black.cgColor
//        gradientLayer.shadowOpacity = 0.8
//        gradientLayer.shadowRadius = 5.0
// 
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }

    
    func imageDetailBackdrop(_ movies: MovieDetails) {
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movies.backdrop
        
        if let url = URL(string: urlImage) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self, let imageData = data else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.imageBackdrop.image = image
                    
//                    let fadeView = UIView(frame: self.imageBackdrop.bounds)
//                    fadeView.backgroundColor = UIColor.black.withAlphaComponent(1)
//                    self.imageBackdrop.addSubview(fadeView)
                    
                    let blurEffect = UIBlurEffect(style: .light)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = self.imageBackdrop.bounds
                    self.imageBackdrop.addSubview(blurView)
                }
            }.resume()
        }
    }

    func imageDetail(_ movies: MovieDetails) {
//        self.imageMovie.image = movies.posterPath
              let baseURLImage = "https://image.tmdb.org/t/p/w500"
              let urlImage = baseURLImage + movies.posterPath
                  if let url = URL(string: urlImage) {
                    URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
                      DispatchQueue.main.async {
      //                    print("Here")
                       self.imageMovie.image = UIImage(data: imageData)
                          
                      }
                        
                    }.resume()
                      
                }
          }
    func labelTitle(_ movies: MovieDetails) {
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelTitle.textColor = UIColor.white
        labelTitle.text = movies.originalTitle
    }
    func labeldDate(_ movies: MovieDetails) {
        labelReleaseDate.text = "Fecha de lanzamiento: \(movies.releaseDate)"
        labelReleaseDate.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        labelReleaseDate.textColor = UIColor.white
    }
    func stackViewStars(_ movies: MovieDetails) {
        let starsMaskView = StarMaskView()
        stackViewStars.addArrangedSubview(starsMaskView)
    }
    func labelGenderMovie(_ movies: Genre) {
        labelGender.text = Genre().name
    }
    func labelDescriptionTitle(_ movies: MovieDetails) {
        labelDescriptionTitle.text = "Description:"
        labelDescriptionTitle.font = UIFont(name: "Helvetica-Bold", size: 20)
        labelDescriptionTitle.textColor = UIColor.black
    }
    func labelDescriptionText(_ movies: MovieDetails) {
        labelDescriptionText.text = movies.overview
        labelDescriptionText.textAlignment = .justified
        labelDescriptionText.font = UIFont(name: "thaoma", size: 16)
        labelDescriptionText.textColor = UIColor.darkGray
    }
}
 


class StarMaskView: UIView {
  let progressView: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.translatesAutoresizingMaskIntoConstraints = false
    progressView.tintColor = .yellow
    progressView.progress = 0.84
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
    // Tamaño de cada estrella
    let starWidth = bounds.width / 10
    let starHeight = bounds.height / 10
    // Crear la capa de máscara
    let maskLayer = CAShapeLayer()
    // Posicionar cada estrella en fila
    for i in 0..<10 {
      let xOffset = CGFloat(i) * starWidth
      // Crear la forma de cada estrella
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
      // Crear una capa de forma y asignar la forma de la estrella
      let starMaskLayer = CAShapeLayer()
      starMaskLayer.path = starPath.cgPath
      starMaskLayer.fillColor = UIColor.yellow.cgColor // Color del fondo
      maskLayer.addSublayer(starMaskLayer)
      // Crear una capa de borde
      let borderLayer = CAShapeLayer()
      borderLayer.path = starPath.cgPath
      borderLayer.fillColor = nil // No rellenar
      borderLayer.strokeColor = UIColor.yellow.cgColor // Color del borde
      borderLayer.lineWidth = 1.0 // Grosor del borde
      borderLayer.frame = bounds
      layer.insertSublayer(borderLayer, at: 0) // Insertar detrás de la capa de fondo
    }
    // Asignar la capa de máscara a la vista
    layer.mask = maskLayer
  }
}
