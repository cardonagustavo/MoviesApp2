//
//  GetStarted.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.
//

import UIKit


@objc protocol GetStartedViewDelegate: AnyObject {
 //   func tapButtonGetStartedShowToLogin(_ getStartedView: GetStartedView)
}

protocol GetStartedViewProtocol {
    func updateLabel()
    func updateButton()
    
}


class GetStartedView: UIView {
    
    @IBOutlet weak var delegate: GetStartedViewDelegate?
    
    @IBOutlet private weak var labelWelcome: UILabel!
    
    @IBOutlet private weak var buttonUpdate: UIButton!
    
    @IBAction func buttonGetStarted(_ sender: UIButton) {
//        self.delegate?.tapButtonGetStartedShowToLogin(self)
    }
    
    func updateLabel() {
        self.labelWelcome.font = UIFont(name: "verdana", size: 25)
        self.labelWelcome.textAlignment = .center
    }
}

extension GetStartedView: GetStartedViewProtocol {
    func updateButton() {
        self.buttonUpdate.backgroundColor? = UIColor.black
    }
}


