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
}





