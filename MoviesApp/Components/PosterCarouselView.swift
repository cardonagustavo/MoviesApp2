//
//  PosterCarouselView.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 1/04/24.
//
import UIKit

/// A part of the app that shows movie pictures one after another on its own.
class PosterCarouselView: UIView {
    // These are special things that only this part of the app knows about.
    
    /// This is the spot where the movie picture shows up.
    private var posterImageView: UIImageView!
    
    /// A list of web addresses that tell us where to find the movie pictures.
    private var posterURLs: [String] = []
    
    /// This number tells us which movie picture we are looking at right now.
    private var currentPosterIndex = 0
    
    /// A clock that tells us when to show the next picture.
    private var changePosterTimer: Timer?
    
    /// A place to keep pictures after we get them so we don't have to get them again.
    private let imageCache = NSCache<NSString, UIImage>()
    
    // These are instructions on how to make this part of the app ready to use.
    
    /// Makes the view ready with a size and place.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// Makes the view ready using a storyboard, which is a tool for drawing the app.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // This part is like a cleanup crew.
    
    /// Stops showing pictures and cleans up when we are done with this part.
    deinit {
        stopCarousel()
    }
    
    // These instructions set up the room for showing the movie pictures.
    
    /// Gets everything ready to show the movie pictures.
    private func setupView() {
        posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill // Makes sure the picture fills the space nicely.
        posterImageView.clipsToBounds = true // Cuts off any part of the picture that is too big.
        posterImageView.translatesAutoresizingMaskIntoConstraints = false // We can tell it where to sit.
        addSubview(posterImageView) // Puts the spot for the picture in this part of the app.

        // Tells the picture spot to fill up the whole space.
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // These are like doors for other parts of the app to use this one.
    
    /// Starts showing the movie pictures one by one.
    /// - Parameter posterPaths: A list of web addresses for the movie pictures.
    func startCarousel(with posterPaths: [String]) {
        posterURLs = posterPaths
        loadPoster(at: currentPosterIndex) // Shows the first picture to start with.
        
        // Sets up the clock to change pictures on its own.
        changePosterTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                                 selector: #selector(changePoster),
                                                 userInfo: nil, repeats: true)
    }
    
    /// Stops the clock and the showing of pictures.
    func stopCarousel() {
        changePosterTimer?.invalidate() // Stops the clock.
        changePosterTimer = nil // Throws away the clock.
    }
    
    // These are secret tools that only this part of the app uses.
    
    /// Gets a movie picture ready and shows it.
    /// - Parameter index: Tells us which picture to get.
    private func loadPoster(at index: Int) {
        let urlString = posterURLs[index] // Gets the web address for the picture.
        guard let url = URL(string: urlString) else { return } // Changes the address into something we can use.
        
        // If we already have the picture, just show it.
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            posterImageView.image = cachedImage
            return
        }
        
        // If we don't have the picture, go get it, keep it, and then show it.
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageCache.setObject(image, forKey: urlString as NSString) // Keeps the picture.
                if self.currentPosterIndex == index { // If we're still looking at the same spot.
                    self.posterImageView.image = image // Updates the spot with the new picture.
                }
            }
        }.resume() // Starts the task to get the picture.
    }

    /// Moves to the next movie picture.
    @objc private func changePoster() {
        currentPosterIndex = (currentPosterIndex + 1) % posterURLs.count // Figures out which is the next picture.
        loadPoster(at: currentPosterIndex)
        
        // Makes the change of pictures look nice and smooth.
        UIView.transition(with: posterImageView, duration: 1.0,
                          options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
