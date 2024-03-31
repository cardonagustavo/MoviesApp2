//
//  shortLoginViewController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 16/03/24.


import UIKit

class ShortLoginViewController: UIViewController {
    var loginView: LoginViewProtocol? { self.view as? LoginViewProtocol }
    var loginStrategy: LoginStrategy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginStrategy = ShortLoginStrategy(viewController: self)
    }
}
