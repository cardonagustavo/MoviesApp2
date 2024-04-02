//
//  GetStarted.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.
//

import UIKit

/// Protocolo para manejar eventos en la vista de inicio.
@objc protocol GetStartedViewDelegate: AnyObject {
    //func tapButtonGetStartedShowToLogin(_ getStartedView: GetStartedView)
}

/// Vista de inicio que muestra un mensaje de bienvenida y un botón para comenzar.
class GetStartedView: UIView {
    
    /// Delegado para manejar eventos en la vista de inicio.
    @IBOutlet weak var delegate: GetStartedViewDelegate?
    
    /// Etiqueta que muestra el título de bienvenida.
    @IBOutlet private weak var labelWelcomeTitle: UILabel!
    
    /// Etiqueta que muestra el texto de bienvenida.
    @IBOutlet weak var labelWelcomeText: UILabel!
    
    /// Botón para comenzar.
    @IBOutlet private weak var buttonUpdate: ButtonComponent!
    
    /// Método llamado cuando se presiona el botón de inicio.
    @IBAction func buttonGetStarted(_ sender: UIButton) {
        //self.delegate?.tapButtonGetStartedShowToLogin(self)
    }
    
    /// Método llamado cuando la vista se mueve a su super vista.
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // Se verifica que el botón no sea nulo y luego se llama al método para animar el gradiente.
        buttonUpdate?.animateGradient()
    }
    /// Actualiza los componentes de la vista con los textos localizados y el estilo.
    func updateComponents() {
        self.labelWelcomeTitle.text = StringsLocalizable.GetStartView.labelWelcomeTitle.localized()
        self.labelWelcomeTitle.font = UIFont(name: "verdana", size: 25)
        self.labelWelcomeTitle.textAlignment = .center
        
        self.labelWelcomeText.text = StringsLocalizable.GetStartView.labelWelcomeText.localized()
        
//        self.buttonUpdate.setupButton()
//        self.buttonUpdate.backgroundColor? = UIColor.black
        self.buttonUpdate.setTitle(StringsLocalizable.GetStartView.buttonGetStarted.localized(), for: .normal)
    }
}
