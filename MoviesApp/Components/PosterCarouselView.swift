//
//  PosterCarouselView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/04/24.
//

import UIKit

/// Una vista que muestra un carrusel de pósters de películas que rota automáticamente a través de las imágenes.
class PosterCarouselView: UIView {
    // MARK: - Private Properties
    
    /// La vista de imagen que muestra el póster actual.
    private var posterImageView: UIImageView!
    
    /// Un arreglo de URLs de strings que representan las ubicaciones de los pósters de las películas.
    private var posterURLs: [String] = []
    
    /// El índice del póster actual que se muestra en el carrusel.
    private var currentPosterIndex = 0
    
    /// Un temporizador que cambia el póster actual a intervalos regulares.
    private var changePosterTimer: Timer?
    
    /// Un caché de imágenes para almacenar y reutilizar imágenes descargadas.
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Deinitializer
    
    deinit {
        stopCarousel()
    }
    
    // MARK: - Setup Methods
    
    /// Configura la vista y sus subvistas.
    private func setupView() {
        posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill // La imagen se ajustará para llenar el contenedor.
        posterImageView.clipsToBounds = true  // Evita que la imagen se desborde.
        posterImageView.translatesAutoresizingMaskIntoConstraints = false // Usa Auto Layout.
        addSubview(posterImageView)

        // Establece constraints para que `posterImageView` llene el contenedor.
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    /// Inicia el carrusel con un conjunto dado de URLs de pósters.
    /// - Parameter posterPaths: Un arreglo de strings que contienen las URLs de los pósters.
    func startCarousel(with posterPaths: [String]) {
        posterURLs = posterPaths
        loadPoster(at: currentPosterIndex)  // Carga inicial de la primera imagen.
        
        // Configura el temporizador para rotar los pósters automáticamente.
        changePosterTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                                 selector: #selector(changePoster),
                                                 userInfo: nil, repeats: true)
    }
    
    /// Detiene el carrusel y limpia el temporizador.
    func stopCarousel() {
        changePosterTimer?.invalidate()
        changePosterTimer = nil
    }
    
    // MARK: - Private Methods
    
    /// Carga y muestra el póster en el índice especificado.
    /// - Parameter index: El índice del póster a cargar.
    private func loadPoster(at index: Int) {
        let urlString = posterURLs[index]
        guard let url = URL(string: urlString) else { return }
        
        // Verifica si la imagen ya está en caché y la muestra si es así.
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            posterImageView.image = cachedImage
            return
        }
        
        // Descarga la imagen si no está en caché y la almacena.
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                if self.currentPosterIndex == index {
                    self.posterImageView.image = image
                }
            }
        }.resume()
    }

    /// Cambia al siguiente póster en el carrusel.
    @objc private func changePoster() {
        currentPosterIndex = (currentPosterIndex + 1) % posterURLs.count
        loadPoster(at: currentPosterIndex)
        
        // Anima la transición de pósters.
        UIView.transition(with: posterImageView, duration: 1.0,
                          options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
