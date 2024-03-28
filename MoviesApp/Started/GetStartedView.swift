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


class GetStartedView: UIView {
    
    @IBOutlet weak var delegate: GetStartedViewDelegate?
    
    @IBOutlet private weak var labelWelcomeTitle: UILabel!
    
    
    @IBOutlet weak var labelWelcomeText: UILabel!
    
    
    @IBOutlet private weak var buttonUpdate: UIButton!
    
    @IBAction func buttonGetStarted(_ sender: UIButton) {
        //                self.delegate?.tapButtonGetStartedShowToLogin(self)
    }
    
    func updateComponents() {
        self.labelWelcomeTitle.text = StringsLocalizable.GetStartView.labelWelcomeTitle.localized()
        self.labelWelcomeTitle.font = UIFont(name: "verdana", size: 25)
        self.labelWelcomeTitle.textAlignment = .center
        
        self.labelWelcomeText.text = StringsLocalizable.GetStartView.labelWelcomeText.localized()
        
        self.buttonUpdate.backgroundColor? = UIColor.black
        self.buttonUpdate.setTitle(StringsLocalizable.GetStartView.buttonGetStarted.localized(), for: .normal)

    }
    
}



