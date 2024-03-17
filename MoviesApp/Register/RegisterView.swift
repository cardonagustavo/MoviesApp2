//  RegisterView.swift
//  MoviesApp
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.

import UIKit

//MARK: - Delegade
@objc protocol RegisterViewDelegate: AnyObject {
    @objc optional func loginViewDidTapLoginButtonWith(_ registerView: RegisterView, email: String, andRememberme rememberme: Bool)
        func loginViewTapButtonRegister(_ registerView:  RegisterView)
        func switchValueChanged(isOn: Bool)

}

//MARK: - protocol
protocol RegisterViewProtocol {
    func customComponentsLabel()
    func customComponentsTextField()
    func updateButtonCreate()
    

}

//MARK: - Class
class RegisterView: UIView {
    
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
    @IBOutlet weak var buttonCreateAccount: UIButton!
    
    
    @IBAction func buttonCreateAccount(_ sender: UIButton) {
        self.delegate?.loginViewTapButtonRegister(self)
        self.delegate?.loginViewDidTapLoginButtonWith?(self, email: self.textFieldEmail.text ?? "", andRememberme: self.labelRememberme.tag == 1 ? true : false)
    }
    
    @IBOutlet weak var textBottom: UILabel!
    @IBAction private func taptoCloseKeyBoard(_ gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    @IBOutlet private weak var viewKeyboard: UIView!
    @IBOutlet private weak var viewKeyBoardGroupAnchor: NSLayoutConstraint!
    
    
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
    
    func keyboardDisappear(_ info: KeyboardManager.Info) {
        self.viewKeyBoardGroupAnchor.constant = 0
        
    }
    
    func configureSwitch(isOn: Bool) {
        swithToRememberme.isOn = isOn
        swithToRememberme.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }

    
    @objc public func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchValueChanged(isOn: sender.isOn)
    }


}

//MARK: - Extension
extension RegisterView: RegisterViewProtocol {
    
    

    
    func updateButtonCreate() {
        buttonCreateAccount.setTitle(nil, for: .normal)
        buttonCreateAccount.setTitle("Create Account", for: .normal)
        buttonCreateAccount.setTitleColor(UIColor.black, for: .normal)
        buttonCreateAccount.layer.cornerRadius = 19
    }
    
    func customComponentsLabel() {
        self.labelCreateAccount.font = UIFont(name: "verdana", size: 20)
        self.labelCreateAccount.adjustsFontSizeToFitWidth = false
    }
     
    
    func customComponentsTextField() {
  //      textFieldEmail.placeholder = "E-mail"
        textFieldEmail.leftViewMode = .always
        textFieldEmail.textColor = .black
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        
 //       textFieldNickName.placeholder = "Nick Name"
        textFieldNickName.leftViewMode = .always
        textFieldNickName.textColor = .black
        textFieldNickName.attributedPlaceholder = NSAttributedString(string: "Nick Name", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.black])
    }
}
