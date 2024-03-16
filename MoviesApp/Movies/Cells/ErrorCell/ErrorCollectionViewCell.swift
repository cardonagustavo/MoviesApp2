//
//  ErrorCollectionViewCell.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 12/03/24.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelMessage: UILabel!
    
    fileprivate func updateDataWith(_ text: String) {
        self.labelMessage.text = text
    }
}


extension ErrorCollectionViewCell {
    
    class var identifier: String { "ErrorCollectionViewCell" }
    
    class func buildIn(_ collectionView: UICollectionView, in indexPath: IndexPath, whit text: String) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateDataWith(text)
        return cell ?? Self()
    }
}

