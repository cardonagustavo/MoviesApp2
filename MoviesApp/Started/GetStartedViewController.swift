//
//  GetStartedController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIForCurrentTraitCollection()
        (self.view as? GetStartedView)?.updateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
}

extension GetStartedViewController: GetStartedViewProtocol {
    func updateButton() {
    }
    
    func updateLabel() {
    }

    
    func updateUIForCurrentTraitCollection() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateUIForCurrentTraitCollection()
    }
}
/*
extension GetStartedViewController: GetStartedViewDelegate {
    func tapButtonGetStartedShowToLogin(_ getStartedView: GetStartedView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
//        showDetailViewController(controller, sender: self)
        self.show(controller, sender: self)
    }
}
*/
