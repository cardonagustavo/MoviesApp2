//
//  StringsLocalizable.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/03/24.
//

import Foundation

// MARK: - Strings Localizable

/// Estructura que contiene todas las cadenas localizables de la aplicación.
struct StringsLocalizable {
    
    // MARK: - Get Start View Strings
    
    struct GetStartView {
        static let labelWelcomeTitle = "labelWelcomeTitle"
        static let labelWelcomeText = "labelWelcomeText"
        static let buttonGetStarted = "buttonGetStarted"
    }
    
    // MARK: - Login View Strings
    
    struct LoginView {
        static let textFieldLogin = "textFieldLogin"
        static let buttonLogin = "buttonLogin"
        static let buttonShortLoginOutlet = "buttonShortLoginOutlet"
        static let labelCreateAccount = "labelCreateAccount"
        static let buttonRegister = "buttonRegister"
    }
    
    // MARK: - Details View Strings
    
    struct DetailsView {
        static let labelGeneresTitle = "labelGeneresTitle"
        static let labelDescriptionTitle = "labelDescriptionTitle"
        static let labelPlayTeaser = "labelPlayTeaser"
    }
    
    // MARK: - Register View Strings
    
    struct RegisterView {
        static let secondLabel = "secondLabel"
        static let textFieldEmail = "textFieldEmail"
        static let textFieldNickName = "textFieldNickName"
        static let labelRememberme = "labelRememberme"
        static let buttonCreateAccount = "buttonCreateAccount"
        static let labelTextBottom = "labelTextBottom"
    }
    
    // MARK: - Error View Strings
    
    struct ErrorView {
        static let labelMessage = "labelMessage"
        static let labelReleaseData = "labelReleaseData"
        static let moviesTitle = "moviesTitle"
        static let favoritesTitle = "favoritesTitle"
        static let noResultsMessage = "noResultsMessage"
        static let noFavoritesMessage = "noFavoritesMessage"
    }
    
    // MARK: - Short Login Strings
    
    struct ShortLogin {
        static let labelShortLogin = "labelShortLogin"
    }
    
    // MARK: - Messages alerts or errors

    struct Messages {
        static let checkIfTheUserIsRegistered = "checkIfTheUserIsRegistered"
        static let RegisteredUserSuccessfully = "RegisteredUserSuccessfully"
        static let ErrorRegistering = "ErrorRegistering"
        static let AppDelegateError = "AppDelegateError"
        static let AlreadyInFavorites = "AlreadyInFavorites"
        static let MovieAddedToFavorites = "MovieAddedToFavorites"
        static let SearchOrSaveMovieError = "SearchOrSaveMovieError"
        static let MovieRemovedFromFavorites = "MovieRemovedFromFavorites"
        static let MovieIsNotInFavorites = "MovieIsNotInFavorites"
        static let NotVideoForFilm = "NotVideoForFilm"
        static let NoVideoKeyAvailable = "NoVideoKeyAvailable"
        static let ErrorOccurred = "ErrorOccurred"
        static let EnterEmail = "EnterEmail"
        static let EnterValidEmail = "EnterValidEmail"
        static let EnterNickname = "EnterNickname"
        static let EmailNicknameIsRegistered = "EmailNicknameIsRegistered"
        static let MovieRecoveryError = "MovieRecoveryError"
        static let CollectionViewCellErrorWithIdentifier = "CollectionViewCellErrorWithIdentifier"
        static let LoginErrorTitle = "LoginErrorTitle"
        static let LoginErrorMessage = "LoginErrorMessage"
        static let LoginErrorNeddRegisterTitle = "LoginErrorNeddRegisterTitle"
        static let LoginErrorNeddRegisterMessage = "LoginErrorNeddRegisterMessage"
    }
}



// MARK: - Extension for Localized Strings

extension String {
    
    /// Método que localiza una cadena.
    ///
    /// - Returns: La cadena localizada.
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
