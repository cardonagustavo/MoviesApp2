//
//  ErrorCollectionViewCell.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 12/03/24.
//

import UIKit

// Definición de la celda personalizada
class ErrorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelMessage: UILabel!
    

       var errorMessage: String? {
           didSet {
               labelMessage.text = errorMessage
           }
       }
    
    fileprivate func updateDataWith(_ text: String) {
        labelMessage.text = text
        labelMessage.font = UIFont.italicSystemFont(ofSize: 18.0)
        labelMessage.textColor = UIColor.lightGray
    }
}

extension ErrorCollectionViewCell {
    
    class var identifier: String { "ErrorCollectionViewCell" }

    class func buildIn(_ collectionView: UICollectionView, para indexPath: IndexPath, conTexto text: String) -> ErrorCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? ErrorCollectionViewCell else {
            fatalError("No se pudo reutilizar la celda ErrorCollectionViewCell con identificador: \(self.identifier)")
        }
        cell.updateDataWith(text)
        return cell
    }
}

