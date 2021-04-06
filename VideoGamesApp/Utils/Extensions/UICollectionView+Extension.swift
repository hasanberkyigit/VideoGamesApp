//
//  UICollectionView+Extension.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit
import Foundation

extension UICollectionView{
    
    func registerHomeHeaderCell(){
        register(UINib(nibName: "HomeHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeHeaderCollectionViewCell")
    }
    
}
