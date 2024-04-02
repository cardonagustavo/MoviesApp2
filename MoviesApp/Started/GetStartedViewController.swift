//
//  GetStartedController.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 23/01/24.
//

import UIKit

/// Controlador de vista para la pantalla de inicio.
class GetStartedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Actualiza los componentes de la vista de inicio al cargar la vista.
        (self.view as? GetStartedView)?.updateComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Oculta los botones de navegación en la barra de navegación al aparecer la vista.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
}







