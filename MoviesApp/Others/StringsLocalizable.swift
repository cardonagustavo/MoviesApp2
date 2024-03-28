//
//  StringsLocalizable.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/03/24.
//

import Foundation


struct StringsLocalizable {
    
    struct GetStartView {
        static let labelWelcomeTitle = "labelWelcomeTitle"
        static let labelWelcomeText = "labelWelcomeText"
        static let buttonGetStarted = "buttonGetStarted"
        
    }
    
    struct LoginView {
        static let textFieldLogin = "textFieldLogin"
        static let buttonLogin = "buttonLogin"
        static let buttonShortLoginOutlet = "buttonShortLoginOutlet"
        static let labelCreateAccount = "labelCreateAccount"
        static let buttonRegister = "buttonRegister"
    }
    
    struct DetailsView {
        static let labelGeneresTitle = "labelGeneresTitle"
        static let labelDescriptionTitle = "labelDescriptionTitle"
        static let labelPlayTeaser = "labelGeneresTitle"
    }
    
    struct RegisterView {
        static let labelCreateAccount = "labelCreateAccount"
        static let secondLabel = "secondLabel"
        static let textFieldEmail = "textFieldEmail"
        static let textFieldNickName = "textFieldNickName"
        static let labelRememberme = "labelRememberme"
        static let buttonCreateAccount = "buttonCreateAccount"
        static let labelTextBottom = "labelTextBottom"
    }
    
    struct ErrorView {
        static let labelMessage = "labelMessage"
        static let labelReleaseData = "labelReleaseData"
        static let moviesTitle = "moviesTitle"
        static let favoritesTitle = "favoritesTitle"
    }
    
   
}

extension String {
    func localized() ->  String {
        return NSLocalizedString(self, comment: "")
    }
}
