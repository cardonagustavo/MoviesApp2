//  RegisterView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.

import UIKit

//MARK: - Delegade

/// Protocolo utilizado para gestionar las acciones del registro de usuario.
@objc protocol RegisterViewDelegate: AnyObject {
    /// Método opcional que se llama cuando se toca el botón de registro.
    ///
    /// - Parameters:
    ///   - registerView: Vista de registro que llama al método.
    ///   - email: Correo electrónico proporcionado por el usuario.
    ///   - nickname: Apodo proporcionado por el usuario.
    ///   - rememberme: Indicador booleano que representa si se desea recordar al usuario.
    @objc optional func loginViewDidTapLoginButtonWith(_ registerView: RegisterView, email: String, nickname: String, andRememberme rememberme: Bool)
    
    /// Método requerido que se llama cuando se toca el botón de crear cuenta.
    ///
    /// - Parameter sender: Objeto UIButton que representa el botón de crear cuenta.
    func buttonCreateAccount(_ sender: UIButton)
    
    /// Método requerido que se llama cuando se cambia el valor del interruptor.
    ///
    /// - Parameter isOn: Booleano que indica si el interruptor está activado.
    func switchValueChanged(isOn: Bool)
}

//MARK: - protocol

/// Protocolo utilizado para personalizar los componentes de la vista de registro.
protocol RegisterViewProtocol {
    /// Personaliza los componentes de etiqueta.
    func customComponentsLabel()
    
    /// Personaliza los componentes de campo de texto.
    func customComponentsTextField()
    
    /// Actualiza el aspecto del botón de crear cuenta.
    func updateButtonCreate()
}

//MARK: - Class

/// Clase que representa la vista de registro de usuario.
class RegisterView: UIView {
    
    //MARK: Outlets
    
    @IBOutlet weak var delegate: RegisterViewDelegate?
    
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelCreateAccount: UILabel!
    @IBOutlet weak var logoMovies: UIImageView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldNickName: UITextField!
    @IBOutlet weak var swithToRememberme: UISwitch!
    @IBOutlet weak var labelRememberme: UILabel!
    @IBOutlet weak var buttonCreateAccount: ButtonComponent!
    @IBOutlet weak var labelTextBottom: UILabel!
    @IBOutlet weak var textBottom: UILabel!
    @IBOutlet private weak var viewKeyboard: UIView!
    @IBOutlet private weak var viewKeyBoardGroupAnchor: NSLayoutConstraint!
    
    //MARK: Actions
    
    @IBAction func buttonCreateAccount(_ sender: UIButton) {
        self.delegate?.buttonCreateAccount(sender)
    }
    
    @IBAction private func taptoCloseKeyBoard(_ gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    // MARK: - Lifecycle

    /// Método llamado cuando la vista se mueve a su super vista.
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        
//        // Se verifica que el botón no sea nulo y luego se llama al método para animar el gradiente.
//        buttonCreateAccount?.animateGradient()
//    }

    
    //MARK: - Keyboard Handling
    
    /// Método llamado cuando el teclado aparece.
    ///
    /// - Parameter info: Información sobre el teclado.
    func keyboardAppear(_ info: KeyboardManager.Info) {
        let keyboardHeight = info.frame.size.height
        let maxYKeyboard = info.frame.maxY
        let maxYView = viewKeyboard.frame.maxY
        
        let displacement = maxYKeyboard - maxYView - keyboardHeight
        
        print("""
               El teclado aparece
               Info:
                   - Frame: \(info.frame)
                   - Altura del teclado: \(keyboardHeight)
                   - Posición máxima Y del teclado: \(maxYKeyboard)
                   - Posición máxima Y de la vista: \(maxYView)
                   - Desplazamiento necesario: \(displacement)
           """)
        
        if displacement > 0 {
            viewKeyBoardGroupAnchor.constant = displacement + 50
        } else {
            viewKeyBoardGroupAnchor.constant = 0
        }
    }
    
    /// Método llamado cuando el teclado desaparece.
    ///
    /// - Parameter info: Información sobre el teclado.
    func keyboardDisappear(_ info: KeyboardManager.Info) {
        self.viewKeyBoardGroupAnchor.constant = 0
    }
    
    //MARK: Switch Handling
    
    /// Método utilizado para configurar el interruptor de recordatorio.
    ///
    /// - Parameter isOn: Valor booleano que indica si el interruptor está activado.
    func configureSwitch(isOn: Bool) {
        swithToRememberme.isOn = isOn
        swithToRememberme.isEnabled = true
        swithToRememberme.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    /// Método llamado cuando se cambia el valor del interruptor.
    ///
    /// - Parameter sender: Objeto UISwitch que representa el interruptor.
    @objc public func switchValueChanged(_ sender: UISwitch) {
        let isOn = sender.isOn
        delegate?.switchValueChanged(isOn: sender.isOn)
    }
    
    //MARK: Text Field Handling
    
    /// Método utilizado para obtener el texto del campo de credencial.
    ///
    /// - Returns: El texto del campo de correo electrónico.
    func getCredentialText() -> String? {
           return textFieldEmail.text
       }
}

//MARK: - Extension

extension RegisterView: RegisterViewProtocol {
    
    /// Personaliza los componentes de etiqueta de la vista de registro.
    func customComponentsLabel() {
        self.labelCreateAccount.text = StringsLocalizable.RegisterView.buttonCreateAccount.localized()
        self.labelCreateAccount.font = UIFont(name: "verdana", size: 20)
        self.labelCreateAccount.adjustsFontSizeToFitWidth = false
        
        self.secondLabel.text = StringsLocalizable.RegisterView.secondLabel.localized()
        self.secondLabel.font = UIFont(name: "verdana", size: 20)
        self.secondLabel.adjustsFontSizeToFitWidth = false
        
        self.labelRememberme.text = StringsLocalizable.RegisterView.labelRememberme.localized()
        self.labelRememberme.font = UIFont(name: "verdana", size: 20)
        self.labelRememberme.adjustsFontSizeToFitWidth = false
        
        self.labelTextBottom.text = NSLocalizedString("labelTextBottom", comment: "")
        self.labelTextBottom.font = UIFont(name: "verdana", size: 20)
        self.labelTextBottom.adjustsFontSizeToFitWidth = false
    }
    
    /// Personaliza los componentes de campo de texto de la vista de registro.
    func customComponentsTextField() {
        textFieldEmail.leftViewMode = .unlessEditing
        textFieldEmail.textColor = .black
        textFieldEmail.placeholder = StringsLocalizable.RegisterView.textFieldEmail.localized()
        
        textFieldNickName.leftViewMode = .unlessEditing
        textFieldNickName.textColor = .black
        textFieldNickName.placeholder = StringsLocalizable.RegisterView.textFieldNickName.localized()
    }
    
    /// Actualiza el aspecto del botón de crear cuenta.
    func updateButtonCreate() {
//        buttonCreateAccount.setTitle(nil, for: .normal)
        buttonCreateAccount.setTitle(StringsLocalizable.RegisterView.buttonCreateAccount.localized(), for: .normal)
//        buttonCreateAccount.setTitleColor(UIColor.black, for: .normal)
//        buttonCreateAccount.layer.cornerRadius = 19
    }
}
