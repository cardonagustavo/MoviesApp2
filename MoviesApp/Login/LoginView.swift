//  LoginView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 19/01/24.

import UIKit

// MARK: - Delegado para la vista de inicio de sesión
@objc protocol LoginViewDelegate: AnyObject {
    func tapButtonLoginShowToMoviesCell(_ loginView: LoginView)
    //func tapButtonLoginShowRegisterView(_ loginView: LoginView)
    func buttonShortLogin(_ loginView: LoginView)
}

// MARK: - Protocolo para la vista de inicio de sesión
protocol LoginViewProtocol {
    func textFieldLoginUpdate()
    func setupNavigationBarAppearance()
    func updateLabels()
    func buttonsUpdate()
}

// MARK: - Clase de la vista de inicio de sesión
class LoginView: UIView {
    
    @IBOutlet weak var delegate: LoginViewDelegate?
    
    // @IBOutlet private weak var delegade: LoginViewProtocolDelegade?
    
    // MARK: - Acciones
    
    /// Método llamado al tocar para cerrar el teclado.
    @IBAction private func tapToCloseKeyboard(_gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        buttonLogin.animateGradient()
//    }
    
    
    @IBOutlet weak var ContainerImagesPosters: UIView!
    
    /// Método llamado al tocar el botón de registro.
    @IBAction func buttonRegister(_ sender: UIButton) {
        //self.delegate?.tapButtonLoginShowRegisterView(self)
    }
    
    /// Método llamado al tocar el botón de inicio de sesión.
    @IBAction func buttonTapLogin(_ sender: UIButton) {
        self.delegate?.tapButtonLoginShowToMoviesCell(self)
    }
    
    /// Método llamado al tocar el botón de inicio de sesión corto.
    @IBAction func buttonShortLogin(_ sender: Any) {
        self.delegate?.buttonShortLogin(self)
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var buttonLogin: ButtonComponent!
    @IBOutlet weak var labelCreateAccount: UILabel!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet private weak var groupViewKeyboardView: UIView!
    @IBOutlet private weak var groupViewKeyboardAnchorCenterAxisY: NSLayoutConstraint!
    @IBOutlet weak var labelShortLogin: UILabel!
    @IBOutlet weak var buttonShortLoginOutlet: ButtonComponent!
    
    private var posterCarouselView: PosterCarouselView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Verifica si posterCarouselView ya existe antes de crear una nueva instancia
        if posterCarouselView == nil {
            posterCarouselView = PosterCarouselView()
            posterCarouselView.translatesAutoresizingMaskIntoConstraints = false
            ContainerImagesPosters.addSubview(posterCarouselView)
            
            NSLayoutConstraint.activate([
                posterCarouselView.topAnchor.constraint(equalTo: ContainerImagesPosters.topAnchor),
                posterCarouselView.leadingAnchor.constraint(equalTo: ContainerImagesPosters.leadingAnchor),
                posterCarouselView.trailingAnchor.constraint(equalTo: ContainerImagesPosters.trailingAnchor),
                posterCarouselView.bottomAnchor.constraint(equalTo: ContainerImagesPosters.bottomAnchor)
            ])
        }
        
        // Carga las URLs de los pósters de películas y comienza el carrusel
        let webService = MoviesWebService()
        webService.fetch { [weak self] moviesDTO in
            let posterPaths = moviesDTO.results?.compactMap { $0.poster_path }.map { "https://image.tmdb.org/t/p/w500\($0)" } ?? []
            DispatchQueue.main.async {
                self?.posterCarouselView.startCarousel(with: posterPaths)
            }
        }
    }

    deinit {
        // Asegúrate de detener el carrusel si posterCarouselView no es nil
        posterCarouselView?.stopCarousel()
    }
}

// MARK: - Extensión de la vista de inicio de sesión para implementar el protocolo LoginViewProtocol
extension LoginView: LoginViewProtocol {
    
    // MARK: - Métodos de protocolo
    
    func setupNavigationBarAppearance() {
        let font = UIFont(name: "FONT NAME", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
    }
    
    func keyboardAppear(_ info: KeyboardManager.Info) {
        if info.frame.origin.y < self.groupViewKeyboardView.frame.maxY {
            let delta = info.frame.origin.y -  self.groupViewKeyboardView.frame.maxY
            
            UIView.animate(withDuration: info.animationDuration) {
                self.groupViewKeyboardAnchorCenterAxisY.constant = delta
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyboardDisappear(_ info: KeyboardManager.Info) {
        UIView.animate(withDuration: info.animationDuration) {
            self.groupViewKeyboardAnchorCenterAxisY.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func updateLabels() {
        self.labelCreateAccount.font = UIFont(name: "veradna", size: 18)
        self.labelCreateAccount.textColor = UIColor.principalInvertBackground
        self.labelCreateAccount.layer.cornerRadius = 20.0
        self.labelCreateAccount.text = StringsLocalizable.LoginView.labelCreateAccount.localized()
    }
    
    func buttonsUpdate() {
        self.buttonLogin.setTitle(StringsLocalizable.LoginView.buttonLogin.localized(), for: .normal)
        self.buttonRegister.setTitle(StringsLocalizable.LoginView.buttonRegister.localized(), for: .normal)
        self.buttonRegister.layer.cornerRadius = 20.0
    }

    func getEmailOrNickname() -> String? {
        return textFieldLogin.text
    }
    
    func textFieldLoginUpdate() {
        self.textFieldLogin.font = UIFont(name: "veradna", size: 30)
        self.textFieldLogin.placeholder = StringsLocalizable.LoginView.textFieldLogin.localized()
        self.textFieldLogin.textColor = UIColor.principalInvertBackground
        self.textFieldLogin.layer.cornerRadius = 5.0
    }
    
    /// Clase de la aplicación delegada.
    class YourAppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            setupNavigationBarAppearance()
            return true
        }
        
        func setupNavigationBarAppearance() {
            let font = UIFont(name: "FONT NAME", size: 18) ?? UIFont.systemFont(ofSize: 18)
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.white
            ]
            
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().barTintColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().clipsToBounds = false
            UINavigationBar.appearance().backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
            UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        }
    }
}
